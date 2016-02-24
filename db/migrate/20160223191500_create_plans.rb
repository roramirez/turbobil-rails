class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.text :name
      t.references :admin, index: true
      t.integer :extens
      t.integer :days

      t.timestamps
    end
  end
end
