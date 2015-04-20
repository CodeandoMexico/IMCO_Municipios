class ChangeColumnsToInspections < ActiveRecord::Migration
  def change
         rename_column :inspections, :nombre, :name
         rename_column :inspections, :materia, :matter
         rename_column :inspections, :duracion, :duration
         rename_column :inspections, :norma, :rule
         rename_column :inspections, :antes, :before
         rename_column :inspections, :durante, :during
         rename_column :inspections, :despues, :after
         rename_column :inspections, :sancion, :sanction
  end
end
