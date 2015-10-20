class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :id_user
      t.string :status

      t.timestamps
    end
  end
end
