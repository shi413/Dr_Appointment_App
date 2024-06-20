ActiveAdmin.register Apointment do
  permit_params :doctor_id, :patient_id, :appointment_date, :approved  # Include the `approved` attribute here

  index do
    selectable_column
    id_column
    column :doctor
    column :patient
    column :appointment_date
    column :approved  # Add this line to display the approved status
    actions
  end

  show do
    attributes_table do
      row :id
      row :doctor
      row :patient
      row :appointment_date
      row :approved  # Add this line to display the approved status
    end
  end

  form do |f|
    f.inputs "Appointment" do
      f.input :doctor
      f.input :patient
      f.input :appointment_date
      f.input :approved  # Add this line to include the approved status in the form
    end
    f.actions
  end
  
end
