class AddFrecuencyToReminders < ActiveRecord::Migration
  def change
  	add_column :reminders, :frequency, :integer
  end
end
