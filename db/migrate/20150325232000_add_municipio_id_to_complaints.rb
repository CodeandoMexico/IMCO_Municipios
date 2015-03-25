class AddMunicipioIdToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :municipio_id, :integer
  end
end
