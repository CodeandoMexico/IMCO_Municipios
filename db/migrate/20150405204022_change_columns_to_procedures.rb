class ChangeColumnsToProcedures < ActiveRecord::Migration
  def change
         rename_column :procedures, :nombre, :name
         rename_column :procedures, :duracion, :description
         rename_column :procedures, :costo, :cost
         rename_column :procedures, :vigencia, :validity
         rename_column :procedures, :contacto, :contact
         rename_column :procedures, :tipo, :type_procedure
         rename_column :procedures, :categoria, :category
  end
end
