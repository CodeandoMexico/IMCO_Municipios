class RenameUserIdColumnToBusinessIdFromReminders < ActiveRecord::Migration
  def up
  	rename_column :reminders, :user_id, :business_id
  end
  def down
  	rename_column :reminders, :business_id, :user_id
  end
end
