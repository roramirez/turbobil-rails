ActiveAdmin.register Plan do

  scope_to :current_admin

  permit_params :name, :extens, :days, :mount


  form do |f|
    f.inputs "Details" do
      f.input :name,    :as => :string
      f.input :extens
      f.input :days
      f.input :mount
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :extens
      row :days
      row :mount
    end
  end

  index do
    column :name
    column :extens
    column :days
    column :mount
    actions
  end

end
