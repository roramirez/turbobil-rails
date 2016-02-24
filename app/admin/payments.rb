ActiveAdmin.register Payment do

  scope_to :current_admin

  permit_params :comment, :customer_id, :status, :gateway_payments_id, :mount

  filter :customer, :collection => proc {Customer.where admin: current_admin }

  form do |f|
    f.inputs "Details" do
      f.input :comment,             :as => :string
      f.input :customer_id,         :as => :string
      f.input :status,              :as => :integer
      f.input :gateway_payments_id, :as => :integer
      f.input :mount
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :comment
      row :customer
      row :status
      row :gateway_payments
      row :mount
    end
  end

  index do
    column :comment
    column :customer
    column :status_label
    column :gateway_payment
    column :mount
    actions
  end

end
