class AddUserIdToGatewayPayments < ActiveRecord::Migration
  def change
    add_column :gateway_payments, :user_id, :text
  end
end
