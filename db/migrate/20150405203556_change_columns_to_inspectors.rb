class ChangeColumnsToInspectors < ActiveRecord::Migration
  def change
          rename_column :inspectors, :nombre, :name
         rename_column :inspectors, :vigencia, :validity
         rename_column :inspectors, :materia, :matter
         rename_column :inspectors, :contacto, :contact
         rename_column :inspectors, :foto, :photo
  end
end
