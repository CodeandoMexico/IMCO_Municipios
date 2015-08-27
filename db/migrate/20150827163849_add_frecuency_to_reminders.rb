class AddFrecuencyToReminders < ActiveRecord::Migration
  def up
  	add_column :reminders, :frequency, :integer
  	add_column :reminders, :frequency_count, :integer
  end
  def down
  	remove_column :reminders, :frequency, :integer
  end
end
