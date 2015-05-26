class CreateUserProcedures < ActiveRecord::Migration
  def change
    create_table :user_procedures do |t|
      t.integer :user_id
      t.integer :procedure_id

      t.timestamps
    end
  end
end
