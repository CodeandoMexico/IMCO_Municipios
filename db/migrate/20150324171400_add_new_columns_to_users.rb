class AddNewColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :text
    add_column :users, :operation_license, :string
    add_column :users, :operation_license_file, :string
    add_column :users, :land_permission_file, :string
  end
end
