class ChangeCategoryLeanrColumn < ActiveRecord::Migration
   def up
    add_column :learns, :for_admin, :boolean, :default=> false
    remove_column :learns, :category, :text
  end

  def down
    remove_column :learns, :for_admin, :boolean, :default=> false
  end
end
