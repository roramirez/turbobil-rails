class AddExpireToAccount < ActiveRecord::Migration
  def change
    add_column :account, :expire, :timestamp
  end
end
