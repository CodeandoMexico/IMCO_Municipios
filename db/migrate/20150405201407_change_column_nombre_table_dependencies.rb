class ChangeColumnNombreTableDependencies < ActiveRecord::Migration
  def change
    rename_column :dependencies, :nombre, :name
    rename_column :dependencies, :municipio_id, :city_id
  end
end
