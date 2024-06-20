ActiveAdmin.register Apointment do
  permit_params :appointment_date, :doctor_id, :patient_id, :approved
  

  filter :appointment_date
  filter :doctor_id
  filter :patient_id

  index do
    selectable_column
    id_column
    column :appointment_date
    column :doctor_id
    column :patient_id
    actions
  end

  form do |f|
    f.inputs do
      f.input :appointment_date
      f.input :doctor_id, as: :select, collection: Doctor.all.map { |doctor| [doctor.name, doctor.id] }
      f.input :patient_id, as: :select, collection: Patient.all.map { |patient| [patient.name, patient.id] }
    end
    f.actions
  end

  controller do
    after_create :send_email
    after_update :send_email

    def send_email(appointment)
      doctor = Doctor.find(appointment.doctor_id)
      ApointmentMailer.apointment_email(doctor, appointment).deliver_now
    end
  end
end
