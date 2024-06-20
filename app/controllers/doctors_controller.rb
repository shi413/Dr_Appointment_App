class DoctorsController < ApplicationController

    skip_before_action :verify_authenticity_token
    before_action :set_doctor, only: [:show, :update, :destroy]

    def index 
        @doctors = Doctor.all
        render json: @doctors, status: :ok
    end

    def show 
        render json: @doctor, status: :ok
    end

    def create 
        @doctor = Doctor.new(doctor_params)
      if @doctor.save
        render json: @doctor, status: :created
      else
        render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update 
        if @doctor.update(doctor_params)
            render json: @doctor, status: :ok
        else
            render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @doctor.destroy
         render json: { notice: 'Doctor was successfully destroyed.' }, status: :ok
    end

    private

    def set_doctor
        @doctor = Doctor.find_by(params[:id])
      end
    
    def doctor_params
        params.require(:doctor).permit(:name, :email)
    end

end
