class Payment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :gateway_payments
  belongs_to :plans

  require "active_merchant/billing/rails"
  include CustomerHelper

  validates :valid_card, :inclusion => {:in => [true], :message => 'Invalid Credit Card'}
  validates :plan_id, :presence => true, :numericality => { :greater_than => 0 }

  PROCESSING, FAILED, SUCCESS = 0, 2, 1
  def status_label
    status_payment status
  end

  def process_payment(creditcard)
    ActiveMerchant::Billing::Base.mode = :test
    self.status = PROCESSING

    response = gateway.purchase(mount, creditcard)

    self.gateway_payments_id = auth.id
    logger.debug response.message
    if response.success?
      self.authorization_code = response.params["authorization_code"]
      self.transaction_id  = response.params["transaction_id"]
      self.status = SUCCESS
    else
      self.status = FAILED
    end
    return self
  rescue Exception => e
    self.status = FAILED
    return self
  end

  def success?
    self.status == SUCCESS
  end

  private
  def gateway
    ActiveMerchant::Billing::AuthorizeNetGateway.new(
      :login    => auth.user_id,
      :password => auth.api_key)
  end

  def auth
    @@auth ||= GatewayPayment.find(1)
  end

end
