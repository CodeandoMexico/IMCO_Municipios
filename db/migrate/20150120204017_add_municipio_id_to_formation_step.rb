class AddMunicipioIdToFormationStep < ActiveRecord::Migration
  def change
    add_column :formation_steps, :municipio_id, :int
  end
end
