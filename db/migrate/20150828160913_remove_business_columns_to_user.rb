class RemoveBusinessColumnsToUser < ActiveRecord::Migration
  def up
  	remove_column :users, :city_id, :integer
  	remove_column :users, :business_name, :text
  	remove_column :users, :address, :text
  	remove_column :users, :operation_license, :string
  	remove_column :users, :operation_license_file, :text
  	remove_column :users, :land_permission_file, :text
  	remove_column :users, :phone, :text
  	remove_column :users, :schedule, :text
  	remove_column :users, :line_id, :integer
  	remove_column :users, :latitude, :string
  	remove_column :users, :longitude, :string
  end
  def down
    add_column :users, :city_id, :integer
  	add_column :users, :business_name, :text
  	add_column :users, :address, :text
  	add_column :users, :operation_license, :string
  	add_column :users, :operation_license_file, :text
  	add_column :users, :land_permission_file, :text
  	add_column :users, :phone, :text
  	add_column :users, :schedule, :text
  	add_column :users, :line_id, :integer
  	add_column :users, :latitude, :string
  	add_column :users, :longitude, :string
  end
end
