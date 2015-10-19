class AddSuperUserToUser < ActiveRecord::Migration
  def change
  	add_column :users, :is_super_user, :boolean, :default => false
  end
end
