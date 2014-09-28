class CustomerController < ApplicationController
  layout "customer"

  before_filter :authenticate_customer!

  def create
    @customer = Customer.new(params[:customer].permit(:email, :name))
    @customer.save

    redirect_to customer_path
  end

  def calls
    @calls = calls_filtered
    @calls = @calls.page(params[:page]).per(10)
  end

  def calls_filtered

    @calls = current_customer.calls

    if params[:call_start].blank? and  params[:call_end].blank?
      params[:call_start] =  DateTime.now.beginning_of_day.strftime('%Y/%m/%d %H:%M:%S')
      params[:call_end] = DateTime.now.end_of_day.strftime('%Y/%m/%d %H:%M:%S')
    end

    @calls = @calls.sorted(params[:sort]).filter(params.slice(:ip, :call_start, :call_end))

  end

  def accounts
    @accounts = current_customer.accounts.page(params[:page]).per(10)
  end

  def prices
    #TODO
  end

  def dashboard
    #TODO
  end
end