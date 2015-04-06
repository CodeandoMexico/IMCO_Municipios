class ChangeColumnDuracionToProcedures < ActiveRecord::Migration
  def change
             rename_column :procedures, :description, :long
  end
end
