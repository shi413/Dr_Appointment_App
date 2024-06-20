class AddApprovalToApointments < ActiveRecord::Migration[7.1]
  def change
    add_column :apointments, :approved, :boolean
    add_column :apointments, :approval_token, :string
  end
end
