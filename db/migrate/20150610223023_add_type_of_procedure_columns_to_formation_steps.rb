class AddTypeOfProcedureColumnsToFormationSteps < ActiveRecord::Migration
  def change
    add_column :formation_steps, :type_of_procedure, :text
  end
end
