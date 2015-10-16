class AddColumnsSwitchToCities < ActiveRecord::Migration
  def change
  	add_column :cities, :has_federal_documentation, :boolean, :default => true
  	add_column :cities, :has_state_documentation, :boolean, :default => true
  end
end
