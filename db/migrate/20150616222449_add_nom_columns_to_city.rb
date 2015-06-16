class AddNomColumnsToCity < ActiveRecord::Migration
  def change
       add_column :cities, :regulations_path, :text
  end
end
