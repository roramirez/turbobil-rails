class AddExtensToCustomer < ActiveRecord::Migration
  def change
    add_column :customer, :extens, :integer
  end
end
