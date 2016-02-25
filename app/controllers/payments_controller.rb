class PaymentsController < ApplicationController

  layout "customer"
  before_filter :authenticate_customer!

  def new
    @payment = Payment.new
    @creditcard = ActiveMerchant::Billing::CreditCard.new
  end

  def create
    @payment = Payment.new(payment_params)
    current_customer.payments << @payment

    @creditcard = ActiveMerchant::Billing::CreditCard.new(params[:creditcard])
    @payment.mount = @payment.plan.mount

    @payment.valid_card = @creditcard.valid?
    if @payment.valid?
      @payment = @payment.process_payment(@creditcard)
      if @payment.success?
        @payment.save

        # other operations after payment
        @current_customer.extens = @payment.plan.extens
        @current_customer.save

        flash[:notice] = 'Payment Success'
        redirect_to payments_url and return
      else
        flash[:error] = 'Payment Failed'
      end
    end
    render :action => :new
  end

  private
    def payment_params
      params.require(:payment).permit(:plan_id)
    end

end
