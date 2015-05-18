class AddColumnsToUserBusiness < ActiveRecord::Migration
 def up
  add_column :users, :phone, :text
  add_column :users, :schedule, :text
  add_column :users, :line_id, :integer
  add_column :users, :latitude, :string
  add_column :users, :longitude, :string
end
def down
  remove_column :users, :phone, :text
  remove_column :users, :schedule, :text
  remove_column :users, :line_id, :integer
  remove_column :users, :latitude, :decimal, {:precision=>10, :scale=>6}
  remove_column :users, :longitude, :decimal, {:precision=>10, :scale=>6}
end
end
