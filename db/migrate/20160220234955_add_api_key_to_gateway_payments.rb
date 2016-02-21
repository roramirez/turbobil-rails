class AddApiKeyToGatewayPayments < ActiveRecord::Migration
  def change
    add_column :gateway_payments, :api_key, :text
  end
end
