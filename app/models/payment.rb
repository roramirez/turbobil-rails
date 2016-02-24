class Payment < ActiveRecord::Base
  include CustomerHelper

  belongs_to :customer
  belongs_to :gateway_payments
  belongs_to :plans

  def status_label
    status_payment status
  end

end
