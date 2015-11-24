class AddColumnsToLearn < ActiveRecord::Migration
  def change
  	add_column :learns, :name, :text
  	add_column :learns, :description, :text
  end
end
