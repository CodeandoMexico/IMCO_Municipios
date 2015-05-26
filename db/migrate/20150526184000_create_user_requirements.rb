class CreateUserRequirements < ActiveRecord::Migration
  def change
    create_table :user_requirements do |t|
      t.integer :user_id
      t.integer :requirement_id

      t.timestamps
    end
  end
end
