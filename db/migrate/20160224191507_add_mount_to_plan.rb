class AddMountToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :mount, :float
  end
end
