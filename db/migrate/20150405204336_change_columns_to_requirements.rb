class ChangeColumnsToRequirements < ActiveRecord::Migration
  def change
         rename_column :requirements, :nombre, :name
         rename_column :requirements, :descripcion, :description
         rename_column :requirements, :municipio_id, :city_id
  end
end
