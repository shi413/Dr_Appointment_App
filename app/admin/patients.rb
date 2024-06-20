ActiveAdmin.register Patient do

  permit_params :name, :email

  index do
    selectable_column
    id_column
    column :name
    column :email
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
    end
    f.actions
  end
end
