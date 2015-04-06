class ChangeColumnTypeToUserFormationSteps < ActiveRecord::Migration
  def change
          rename_column :user_formation_steps, :tipo, :type_user_formation_step
  end
end
