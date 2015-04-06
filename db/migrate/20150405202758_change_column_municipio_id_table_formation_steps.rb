class ChangeColumnMunicipioIdTableFormationSteps < ActiveRecord::Migration
  def change
     rename_column :formation_steps, :municipio_id, :city_id
  end
end
