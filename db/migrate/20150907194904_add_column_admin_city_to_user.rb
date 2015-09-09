class AddColumnAdminCityToUser < ActiveRecord::Migration
  def change
  	 add_column :users, :city_id, :integer #city_id es solo para los empresarios
  end
end