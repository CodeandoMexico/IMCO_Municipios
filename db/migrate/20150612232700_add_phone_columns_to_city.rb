class AddPhoneColumnsToCity < ActiveRecord::Migration
  def change
    add_column :cities, :contact_phone, :text
  end
end
