class RemoveTipoFromRequirements < ActiveRecord::Migration
  def change
    remove_column :requirements, :tipo, :text
  end
end
