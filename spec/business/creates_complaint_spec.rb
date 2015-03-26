require 'rails_helper'

feature 'A business enters the inspections view' do
  attr_reader :municipio

  before do
    @municipio = create :municipio
  end

  scenario 'and creates a new complaint' do
    # go to the city new complaint section
    visit new_municipio_complaint_path(municipio)

    choose(COMPLAINTS['regulation_violation'])
    click_on I18n.t('complaints.new.save_button')
  end
end
