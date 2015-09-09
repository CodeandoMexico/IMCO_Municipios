class CreateCatTwitters < ActiveRecord::Migration
  def change
    create_table :cat_twitters do |t|
      t.text :state
      t.text :town
      t.text :twitter

      t.timestamps
    end
  end
end
