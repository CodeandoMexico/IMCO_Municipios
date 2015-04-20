class ChangeColumnMunicipioIdToUsers < ActiveRecord::Migration
  def change
      rename_column :users, :municipio_id, :city_id
  end
end
