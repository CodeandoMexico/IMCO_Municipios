class RenameMunicipiosToCities < ActiveRecord::Migration
  def change
     rename_table :municipios, :cities
  end
end
