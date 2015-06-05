class AddPrivacityFlieColumnsToCities < ActiveRecord::Migration
  def change
      add_column :cities, :privacy_file, :text
  end
end
