class RenameUserIdColumnToBusinessIdFromUserFormationSteps < ActiveRecord::Migration
  def up
  	rename_column :user_formation_steps, :user_id, :business_id
  end
  def down
  	rename_column :user_formation_steps, :business_id, :user_id
  end
end
