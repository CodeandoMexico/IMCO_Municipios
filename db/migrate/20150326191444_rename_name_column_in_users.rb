class RenameNameColumnInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :name, :business_name
  end

  def down
    rename_column :users, :business_name, :name
  end
end
