class AddColumnUsingToBusiness < ActiveRecord::Migration
  def change
       add_column :businesses, :using, :boolean, :default => false
  end
end
