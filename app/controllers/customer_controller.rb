class CustomerController < ApplicationController
  layout "customer"

  before_filter :authenticate_customer!

  def profile
    @user = current_customer
  end

  def update_profile
    @user = current_customer

    params_to_update = profile_params.dup
    if params_to_update[:password].blank?
      params_to_update.delete(:password)
      params_to_update.delete(:password_confirmation)
    end

    if @user.update_attributes(params_to_update)
      flash[:notice] = "Successfully updated your profile."
      redirect_to :action => 'profile'
    else
      flash[:error] = "Dont update profile."
      render :profile
    end
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

  def edit_account
    @account = current_customer.accounts.find(params[:id])
  end

  def update_account
    @account = current_customer.accounts.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:notice] = "Successfully updated account."
      redirect_to :action => 'edit_account', :id => @account
    else
      flash[:error] = "Dont update account."
      render :edit_account
    end
  end

  def prices
    @prices_customer = PriceCustomer.get_join_route(current_customer.price_customer_id)
                                    .page(params[:page])
                                    .sorted(params[:sort])
                                    .per(10)
  end

  def dashboard
    @min = current_customer.minutes_call_last_days.sort
    @minutes = []
    @min.each do |m|
      @minutes.append({date: m[0], minutes: m[1]})
    end
  end

  private
  def profile_params
    params.require(:customer).permit(:name, :email, :password)
  end

  def account_params
    params.require(:account).permit(:ip_auth, :password, codec_ids: [])
  end

end
