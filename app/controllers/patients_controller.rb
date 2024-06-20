class PatientsController < ApplicationController

    skip_before_action :verify_authenticity_token
    before_action :set_patient, only: [:show, :update, :destroy]
  
    def index
      @patients = Patient.all
      render json: @patients, status: :ok
    end
  
    def show
      render json: @patient, status: :ok
    end
  
    def create
      @patient = Patient.new(patient_params)
      if @patient.save
        render json: @patient, status: :created
      else
        render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @patient.update(patient_params)
        render json: @patient, status: :ok
      else
        render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @patient.destroy
      render json: { notice: 'Patient was successfully destroyed.' }, status: :ok
    end
  
    private
  
    def set_patient
      @patient = Patient.find_by(params[:id])
    end
  
    def patient_params
      params.require(:patient).permit(:name, :email)
    end
  end
  