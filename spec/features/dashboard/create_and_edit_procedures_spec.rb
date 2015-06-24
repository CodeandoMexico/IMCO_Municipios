require 'rails_helper'

feature 'validate Procedures' do
  attr_reader :admin

  before do
    @admin = create :admin
  end

  scenario 'and validate the insert of Procedures' do
    sign_in admin

    create_dependency
    create_line
    create_requirement

    visit dashboard_path(admin)

    click_on I18n.t('dashboard.menu.procedures')

    create_procedure
  end

  scenario 'and edit Procedure' do
    sign_in admin
    
    create_dependency
    create_line
    create_requirement

    visit dashboard_path(admin)

    click_on I18n.t('dashboard.menu.procedures')

    create_procedure
    
    edit_procedure
  end

  def edit_procedure
      visit edit_dashboard_procedure_path(Procedure.where(name: 'name of procedure').last)

    fill_in 'procedure[name]', with: 'new name of procedure'
    fill_in 'procedure[long]', with: '3 hours'
    fill_in 'procedure[cost]', with: '1000'
    fill_in 'procedure[validity]', with: 'one year'
    fill_in 'procedure[contact]', with: 'name of contact'
    
    select "1", :from => "procedure[sare]"
    select "TM", :from => "procedure[type_procedure]"
    select "Constituye tu empresa", :from => "procedure[category]"
    select "Name of dependency", :from => "procedure[dependency_id]"
    
    click_on I18n.t('dashboard.procedures.form.create_procedures')

    visit dashboard_procedures_path
    expect(page).to have_content 'new name of procedure'
  end

  def create_procedure

    click_on I18n.t('dashboard.procedures.index.new_procedures')
    
    fill_in 'procedure[name]', with: 'name of procedure'
    fill_in 'procedure[long]', with: '3 hours'
    fill_in 'procedure[cost]', with: '1000'
    fill_in 'procedure[validity]', with: 'one year'
    fill_in 'procedure[contact]', with: 'name of contact'   

    select "1", :from => "procedure[sare]"
    select "TM", :from => "procedure[type_procedure]"
    select "Constituye tu empresa", :from => "procedure[category]"
    select "Name of dependency", :from => "procedure[dependency_id]"

    expect(page).to have_content 'Name of line'
    expect(page).to have_content 'Name of requirement'

    click_on I18n.t('dashboard.procedures.form.create_procedures')
    
    visit dashboard_procedures_path
    expect(page).to have_content 'name of procedure'
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