class Patient < ApplicationRecord
    has_many :apointments
    has_many :doctors, through: :apointments

    validates :name, :email, presence: true

    def self.ransackable_associations(auth_object = nil)
        ["apointments", "doctors"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "email", "id", "id_value", "name", "updated_at"]
    end
end
