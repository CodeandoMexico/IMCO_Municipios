class AddColumnsFilesToUsers < ActiveRecord::Migration
  def change
	add_column :cities, :dependency_file, :string
	add_column :cities, :line_file, :string
	add_column :cities, :formation_step_file, :string
	add_column :cities, :requirement_file, :string
	add_column :cities, :procedure_file, :string
	add_column :cities, :inspection_file, :string
	add_column :cities, :inspector_file, :string
  end
end