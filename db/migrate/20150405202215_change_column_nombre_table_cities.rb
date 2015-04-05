class ChangeColumnNombreTableCities < ActiveRecord::Migration
  def change
        rename_column :cities, :nombre, :name
  end
end
