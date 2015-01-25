require 'rails_helper'

feature 'The admin enters the dashboard' do
  attr_reader :admin, :inspections, :city

  before(:each) do
    @city = create :municipio
    dependency = create :dependency, municipio: city
    @admin = create(:admin, municipio: @city)
    @inspections = []
    3.times { @inspections << create(:inspection, dependency: dependency) }

    sign_in_admin(@admin)
  end

  scenario 'and navigates to the inspections' do
    expect(page).to have_content 'Has iniciado sesión.'
    admin_navigates_to_inspection_dashboard
    all_inspections_make_an_appereance
  end

  scenario 'and edits the last inspection with faulty data' do
    admin_navigates_to_inspection_dashboard
    find_last_inspection.click

    expect(page).to have_content I18n.t('dashboard.inspections.edit.title')

    # this test should be more exhaustive, test agaisnt different kinds of data
    # refactor this code when models are validated
    edit_inspection_with_valid_data(last_inspection, new_inspection_title)
    expect(page).to have_content new_inspection_title
  end

  def all_inspections_make_an_appereance
    inspections.each do |inspection|
      expect(page).to have_content inspection.name
    end
  end

  def admin_navigates_to_inspection_dashboard
    visit dashboard_inspections_path
  end

  def last_inspection
    inspections.last
  end

  def find_last_inspection
    find(:xpath, "//a[@href=\'#{edit_dashboard_inspection_path(last_inspection)}\']")
  end

  def edit_inspection_with_valid_data(inspection, title)
    fill_in 'inspection[name]', with: new_inspection_title
    click_on I18n.t('dashboard.inspections.form.create_inspection')
    save_and_open_page
  end

  def new_inspection_title
    'Another inspection name'
  end
end
