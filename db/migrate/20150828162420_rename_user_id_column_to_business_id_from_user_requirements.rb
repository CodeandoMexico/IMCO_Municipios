class RenameUserIdColumnToBusinessIdFromUserRequirements < ActiveRecord::Migration
  def up
  	rename_column :user_requirements, :user_id, :business_id
  end
  def down
  	rename_column :user_requirements, :business_id, :user_id
  end
end
