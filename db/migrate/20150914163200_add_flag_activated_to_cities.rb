class AddFlagActivatedToCities < ActiveRecord::Migration
  def change
  	add_column :cities, :activated, :boolean, :default => false
  end
end
