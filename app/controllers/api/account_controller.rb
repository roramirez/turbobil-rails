class API::AccountController < ApplicationController


  def index
    @account = Account.all
    respond_to do |format|
      format.json { render :json => @account }
      format.text { render :text => @account }
    end
  end

  def enabled
    @account = Account.where(code: params[:id]).first
    if @account.nil?
      @account = Account.new
    end
    respond_to do |format|
      format.json { render :json => @account }
      format.text { render :text => @account.is_enabled }
      format.all  { render :text => @account.is_enabled }
    end
  end

end
