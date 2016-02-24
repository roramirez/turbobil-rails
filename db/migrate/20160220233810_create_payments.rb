class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.text :comment
      t.references :customer, index: true
      t.integer :status
      t.references :gateway_payments, index: true

      t.timestamps
    end
  end
end
