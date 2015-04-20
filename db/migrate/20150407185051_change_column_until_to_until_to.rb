class ChangeColumnUntilToUntilTo < ActiveRecord::Migration
 def change
      rename_column :reminders, :until, :until_to
  end
end
