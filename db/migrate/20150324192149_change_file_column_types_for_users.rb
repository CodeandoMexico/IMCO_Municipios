class ChangeFileColumnTypesForUsers < ActiveRecord::Migration
  def up
    change_column :users, :operation_license_file, :text
    change_column :users, :land_permission_file, :text
  end

  def down
    change_column :users, :operation_license_file, :string
    change_column :users, :land_permission_file, :string
  end
end
