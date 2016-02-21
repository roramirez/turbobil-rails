ActiveAdmin.register GatewayPayment do

  scope_to :current_admin

  permit_params :name, :code, :user_id, :api_key, :secret

#  filter :type_customer



  form do |f|
    f.inputs "Details" do
      f.input :name,          :as => :string
      f.input :code,          :as => :string
    end
    f.inputs "Connection" do
      f.input :user_id,       :as => :string
      f.input :api_key,       :as => :string
      f.input :secret,        :as => :password
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :code

    end
    panel "Connection" do
      attributes_table_for gateway_payment do
        row :user_id
        row :api_key
        row :secret
      end
    end

  end

  index do
    column :id
    column :name
    column :code
    actions
  end

end
