class AddNormativasFlieColumnsToCities < ActiveRecord::Migration
  def change
          add_column :cities, :construction_file, :text
          add_column :cities, :land_file, :text
          add_column :cities, :business_file, :text
  end
end
