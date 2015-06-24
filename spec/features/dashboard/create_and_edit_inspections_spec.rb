require 'rails_helper'

feature 'validate Inspections' do
  attr_reader :admin

  before do
    @admin = create :admin
  end

  scenario 'and validate the insert of Inspections' do
    sign_in admin

    create_dependency
    create_line
    create_requirement

    visit dashboard_path(admin)

    click_on I18n.t('dashboard.menu.inspections')

    create_inspections
  end

  scenario 'and edit Procedure' do
    sign_in admin
    
    create_dependency
    create_line
    create_requirement

    visit dashboard_path(admin)

    click_on I18n.t('dashboard.menu.inspections')
    
    create_inspections
    
    edit_inspection
  end


  def edit_inspection
    visit edit_dashboard_inspection_path(Inspection.where(name: 'name of inspection').last)
    fill_in 'inspection[name]', with: 'new name of inspection'
    
    click_on I18n.t('dashboard.inspections.form.create_inspection')

    visit dashboard_inspections_path
    expect(page).to have_content 'new name of inspection'
  end

  def create_inspections

    click_on I18n.t('dashboard.inspections.index.new_inspection')
    
    fill_in 'inspection[name]', with: 'name of inspection'
    fill_in 'inspection[matter]', with: 'example of matter'
    fill_in 'inspection[duration]', with: '1 day'
    fill_in 'inspection[rule]', with: 'example of rule'
    fill_in 'inspection[before]', with: 'do it ...'
    fill_in 'inspection[during]', with: 'do it ...'
    fill_in 'inspection[after]', with: 'do it'
    fill_in 'inspection[sanction]', with: 'you need ..'

    expect(page).to have_content 'Name of line'
    expect(page).to have_content 'Name of requirement'

    select "Name of dependency", :from => "inspection[dependency_id]"
    
    click_on I18n.t('dashboard.inspections.form.create_inspection')
    
    visit dashboard_inspections_path
    expect(page).to have_content 'name of inspection'
  end


  def create_dependency
    visit dashboard_dependencies_path
    click_on I18n.t('dashboard.dependencies.index.new_dependency')
    fill_in 'dependency[name]', with: 'Name of dependency'
    click_on I18n.t('dashboard.dependencies.form.create_dependency')
    visit dashboard_dependencies_path
    expect(page).to have_text('Name of dependency')
    visit dashboard_path(admin)
  end

  def create_line
    visit dashboard_lines_path
    click_on I18n.t('dashboard.lines.index.new_lines')
    fill_in 'line[name]', with: 'Name of line'
    fill_in 'line[description]', with: 'This is a description'
    click_on I18n.t('dashboard.lines.form.create_lines')
    visit dashboard_lines_path
    expect(page).to have_content 'Name of line'
    expect(page).to have_content City.find(admin.city_id).name
    visit dashboard_path(admin)
  end

  def create_requirement
    visit dashboard_requirements_path
    click_on I18n.t('dashboard.requirements.index.new_requirements')
    fill_in 'requirement[name]', with: 'Name of requirement'
    fill_in 'requirement[description]', with: 'description of requirement'
    fill_in 'requirement[path]', with: 'http://pagina_path.php'

    click_on I18n.t('dashboard.requirements.form.create_requirements')
    visit dashboard_requirements_path
    expect(page).to have_content 'Name of requirement'
    visit dashboard_path(admin)
  end


end
