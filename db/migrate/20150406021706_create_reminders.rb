class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.text :name
      t.text :license
      t.date :until

      t.timestamps
    end
  end
end
