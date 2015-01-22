class RenameColumnsFromInspection < ActiveRecord::Migration
  def change
    rename_column :inspections, :nombre, :name
    rename_column :inspections, :materia, :subject
    rename_column :inspections, :duracion, :period
    rename_column :inspections, :norma, :norm
    rename_column :inspections, :antes, :before_tips
    rename_column :inspections, :durante, :during_tips
    rename_column :inspections, :despues, :after_tips
    rename_column :inspections, :sancion, :sanctions
  end
end
