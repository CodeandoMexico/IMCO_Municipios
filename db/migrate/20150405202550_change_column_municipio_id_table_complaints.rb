class ChangeColumnMunicipioIdTableComplaints < ActiveRecord::Migration
  def change
     rename_column :complaints , :municipio_id, :city_id
  end
end
