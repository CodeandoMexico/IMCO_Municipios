class AddCategoryAndSareToProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :categoria, :text
    add_column :procedures, :sare, :text
  end
end
