class PatientMailer < ApplicationMailer
    def appointment_approved_email(appointment)
        @appointment = appointment
        @patient = appointment.patient
        mail(to: @patient.email, subject: 'Your Appointment has been Approved')
    end

    def appointment_rejected_email(appointment)
        @appointment = appointment
        @patient = appointment.patient
        mail(to: @patient.email, subject: 'Your Appointment has been Rejected')
    end
end
