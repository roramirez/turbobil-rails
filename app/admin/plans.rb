ActiveAdmin.register Plan do

  scope_to :current_admin

  permit_params :name, :extens, :days


  form do |f|
    f.inputs "Details" do
      f.input :name,    :as => :string
      f.input :extens
      f.input :days
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :extens
      row :days
    end
  end

  index do
    column :name
    column :extens
    column :days
    actions
  end

end
