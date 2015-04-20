class AddNewColumnToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :user_id, :integer
  end
end
