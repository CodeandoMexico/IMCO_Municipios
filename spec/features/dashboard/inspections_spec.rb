require 'rails_helper'

feature 'The admin enters the dashboard' do
  attr_reader :admin, :inspections, :city

  before(:all) do
    @city = create :municipio
    dependency = create :dependency, municipio: city
    @admin = create(:admin, municipio: @city)
    @inspections = []
    3.times { @inspections << create(:inspection, dependency: dependency) }

    sign_in(@admin)
  end

  scenario 'navigates to the inspections dashboard' do
    # save_and_open_page
    admin_navigates_to_inspection_dashboard
  end

  def admin_navigates_to_inspection_dashboard
    visit dashboard_inspections_path 
  end
end
