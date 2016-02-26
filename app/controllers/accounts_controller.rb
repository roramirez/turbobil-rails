class AccountsController < ApplicationController

  layout "customer"
  before_filter :authenticate_customer!
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :check_max_accounts, only: [:create, :new]

  def new
    @account = Account.new
  end

  def show
  end

  def edit
  end

  def index
    if params[:ids]
      @accounts = current_customer.accounts.find(params[:ids])
    else
      @accounts = current_customer.accounts
                              .page(params[:page]).per(10)
                              .sorted(params[:sort])
    end
  end

  def create
    @account = Account.new(account_params)
    @account.codecs = Codec.all()

    @parent = current_customer.accounts.find_by_parent(true)
    if !@parent.nil?
      @account.expire = @parent.expire
    end
    @account.parent = false
    @account.admin = @current_customer.admin
    current_customer.accounts << @account


    respond_to do |format|
      if @account.save
        format.html { redirect_to  edit_account_path(@account), notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to  edit_account_path(@account), notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_customer.accounts.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:code, :password)
    end

    def check_max_accounts
      if !current_customer.is_maximum_exten
        redirect_to  accounts_url, notice: 'You completed the max extensions.'
      end
    end

end
