class AddCustomReasonFieldToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :custom_reason, :string
  end
end
