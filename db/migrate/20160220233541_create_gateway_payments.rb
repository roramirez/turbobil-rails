class CreateGatewayPayments < ActiveRecord::Migration
  def change
    create_table :gateway_payments do |t|
      t.text :name
      t.text :code
      t.references :admin, index: true

      t.timestamps
    end
  end
end
