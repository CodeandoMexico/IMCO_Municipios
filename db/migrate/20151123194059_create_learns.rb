class CreateLearns < ActiveRecord::Migration
  def change
    create_table :learns do |t|
      t.text :video_id
      t.text :category

      t.timestamps
    end
  end
end
