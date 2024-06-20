class AddRejectionToApointments < ActiveRecord::Migration[7.1]
  def change
    add_column :apointments, :rejected, :boolean
    add_column :apointments, :rejection_token, :string
  end
end
