class CreateFormationSteps < ActiveRecord::Migration
  def change
    create_table :formation_steps do |t|
      t.text :name
      t.text :description
      t.string :type
      t.text :path

      t.timestamps
    end
  end
end
