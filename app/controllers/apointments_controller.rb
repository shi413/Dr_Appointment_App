class ApointmentsController < ApplicationController

  skip_before_action :verify_authenticity_token



  def index
    @apointments = Apointment.all
    render json: @apointments
  end

  def show
    @apointment = Apointment.find(params[:id])
    render json
  end

  def new
    @apointment = Apointment.new
  end

  def create
    @apointment = Apointment.new(apointment_params)
    if @apointment.save
      ApointmentMailer.apointment_email(@apointment.doctor, @apointment).deliver_now
      render json: @apointment, notice: 'Appointment was successfully created.'
    end
  end

  def approve
    @apointment = Apointment.find_by(approval_token: params[:token])
    if @apointment
      @apointment.update(approved: true)
      PatientMailer.appointment_approved_email(@apointment).deliver_now
      render json: { message: 'Appointment approved and patient notified.' }, status: :ok
    else
      render json: { error: 'Invalid approval token.' }, status: :unprocessable_entity
    end
  end

  def reject
    @apointment = Apointment.find_by(rejection_token: params[:token])
    if @apointment
      @apointment.update(rejected: true)
      PatientMailer.appointment_rejected_email(@apointment).deliver_now
      render json: { message: 'Appointment rejected and patient notified.' }, status: :ok
    else
      render json: { error: 'Invalid rejection token.' }, status: :unprocessable_entity
    end
  end

  private

  def apointment_params
    params.require(:apointment).permit(:doctor_id, :patient_id, :appointment_date)
  end
end