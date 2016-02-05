class AddParentToAccount < ActiveRecord::Migration
  def change
    add_column :account, :parent, :boolean, default: true
  end
end
