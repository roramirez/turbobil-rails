class AddVAlidCardToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :valid_card, :boolean
  end
end
