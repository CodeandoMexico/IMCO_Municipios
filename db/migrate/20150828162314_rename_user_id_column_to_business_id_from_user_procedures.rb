class RenameUserIdColumnToBusinessIdFromUserProcedures < ActiveRecord::Migration
  def up
  	rename_column :user_procedures, :user_id, :business_id
  end
  def down
  	rename_column :user_procedures, :business_id, :user_id
  end
end
