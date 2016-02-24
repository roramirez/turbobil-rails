class AddPlanToPayment < ActiveRecord::Migration
  def change
    add_reference :payments, :plan, index: true
  end
end
