class AddContactEmailToMunicipios < ActiveRecord::Migration
def change
    add_column :municipios, :contact_email, :text
  end
end
