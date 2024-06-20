class ApointmentMailer < ApplicationMailer
  default from: 'notifications@example.com'
  

  def apointment_email(doctor, apointment)
    # debugger
    @doctor = doctor
    @apointment = apointment
    @approval_url = approve_apointments_url(token: @apointment.approval_token)
    @rejection_url = reject_apointments_url(token: @apointment.rejection_token) 
    mail(to: @doctor.email, subject: 'New Appointment Booked')
    
  end
end