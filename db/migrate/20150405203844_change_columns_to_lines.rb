class ChangeColumnsToLines < ActiveRecord::Migration
  def change
     rename_column :lines, :nombre, :name
         rename_column :lines, :descripcion, :description
         rename_column :lines, :municipio_id, :city_id
  end
end
