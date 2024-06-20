class Apointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :appointment_date, presence: true
  validate :apointment_time_conflict
  before_create :generate_approval_token
  before_create :generate_rejection_token


  def self.ransackable_associations(auth_object = nil)
    ["doctor", "patient"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["appointment_date", "created_at", "doctor_id", "id", "id_value", "patient_id", "updated_at"]
  end

  private

  def apointment_time_conflict
    if Apointment.where(doctor_id: doctor_id, appointment_date: appointment_date).exists?
      errors.add(:appointment_date, 'is already booked for this doctor.')
    end
  end

  def generate_approval_token
    self.approval_token = SecureRandom.hex(10)
  end

  def generate_rejection_token
    self.rejection_token = SecureRandom.hex(10)
  end
end
