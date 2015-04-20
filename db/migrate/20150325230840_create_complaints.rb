class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :reason
      t.text :description

      t.timestamps
    end
  end
end
