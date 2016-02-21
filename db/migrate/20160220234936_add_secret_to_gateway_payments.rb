class AddSecretToGatewayPayments < ActiveRecord::Migration
  def change
    add_column :gateway_payments, :secret, :text
  end
end
