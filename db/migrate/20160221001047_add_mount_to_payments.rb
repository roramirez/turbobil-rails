class AddMountToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :mount, :float
  end
end
