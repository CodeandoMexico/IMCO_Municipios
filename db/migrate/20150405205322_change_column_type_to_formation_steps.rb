class ChangeColumnTypeToFormationSteps < ActiveRecord::Migration
  def change
      rename_column :formation_steps, :type, :type_formation_step
  end
end
