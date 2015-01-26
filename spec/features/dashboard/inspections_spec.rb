require 'rails_helper'

feature 'The admin enters the dashboard' do
  attr_reader :admin, :dependency, :inspections, :city

  before(:each) do
    @city = create :municipio
    @dependency = create :dependency, municipio: city
    @admin = create(:admin, municipio: @city)
    @inspections = []
    3.times { @inspections << create(:inspection, dependency: dependency) }

    # let's sign in our admin
    # more info in the spec/support/features/session_helpers.rb
    sign_in_admin(@admin)
  end

  scenario 'and navigates to the inspections' do
    expect(page).to have_content 'Has iniciado sesión.'
    admin_navigates_to_inspection_dashboard
    all_inspections_make_an_appereance
  end

  scenario 'and creates an inspection' do
    admin_navigates_to_inspection_dashboard

    # custom method to create inspections, fill in the inspection attributes
    # and create an object
    create_inspection_with({
      name: 'Another inspection',
      subject: 'This is a subject',
      period: '3 months',
      norm: 'Norm text',
      before_tips: 'Before tips text',
      during_tips: 'During tips text',
      after_tips: 'After tips text',
      sanctions: 'Sanctions title',
      dependency: dependency
    })

    expect(page).to have_content 'La inspección fue creada satisfactoriamente.'
    expect(current_path).to eq dashboard_inspections_path
  end

  scenario 'and edits the last inspection with valid data' do
    admin_navigates_to_inspection_dashboard
    find_last_inspection.click

    expect(page).to have_content I18n.t('dashboard.inspections.edit.title')

    # this test should be more exhaustive, test agaisnt different kinds of data
    # refactor this code when models are validated
    edit_inspection(last_inspection, new_inspection_title)
    expect(page).to have_content new_inspection_title
  end

  def create_inspection_with(args)
    click_on I18n.t('dashboard.inspections.index.new_inspection')

    fill_in 'inspection_name', with: args.fetch(:name)
    fill_in 'inspection_subject', with: args.fetch(:subject)
    fill_in 'inspection_period', with: args.fetch(:period)
    fill_in 'inspection_before_tips', with: args.fetch(:norm)
    fill_in 'inspection_norm', with: args.fetch(:before_tips)
    fill_in 'inspection_during_tips', with: args.fetch(:during_tips)
    fill_in 'inspection_after_tips', with: args.fetch(:after_tips)
    fill_in 'inspection_sanctions', with: args.fetch(:sanctions)
    select args.fetch(:dependency).nombre, from: 'inspection_dependency_id'

    click_on I18n.t('dashboard.inspections.form.create_inspection')
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

  def edit_inspection(inspection, title)
    fill_in 'inspection[name]', with: new_inspection_title
    click_on I18n.t('dashboard.inspections.form.create_inspection')
  end

  def new_inspection_title
    'Another inspection name'
  end
end
