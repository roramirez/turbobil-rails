class AddAuthorizationCodeToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :authorization_code, :text
  end
end
