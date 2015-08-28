class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.text :name
      t.text :address
      t.text :phone
      t.text :schedule
      t.integer :user_id
      t.integer :city_id
      t.string :operation_license
      t.text :operation_license_file
      t.text :land_permission_file
      t.integer :line_id
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
