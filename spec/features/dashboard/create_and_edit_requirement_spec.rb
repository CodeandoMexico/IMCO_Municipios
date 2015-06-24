require 'rails_helper'

feature 'validate Formation_Steps' do
  attr_reader :admin

  before do
    @admin = create :admin
  end

  scenario 'and validate the insert of requirements' do
    sign_in admin

    visit dashboard_path(admin)
    click_on I18n.t('dashboard.menu.requirements')
    
    create_requirement
  end

  scenario 'and edit requirement' do
    sign_in admin

    visit dashboard_path(admin)
    click_on I18n.t('dashboard.menu.requirements')
    
    create_requirement
    
    edit_requirement
  end

  def edit_requirement
    visit edit_dashboard_requirement_path(Requirement.where(name: 'Name of requirement').last)
    fill_in 'requirement[name]', with: 'new name of requirement'
    fill_in 'requirement[description]', with: 'description of requirement'
    fill_in 'requirement[path]', with: 'http://pagina_path.php'

    click_on I18n.t('dashboard.requirements.form.create_requirements')
    visit dashboard_requirements_path
    expect(page).to have_content 'new name of requirement'
  end

  def create_requirement
    click_on I18n.t('dashboard.requirements.index.new_requirements')
    
    fill_in 'requirement[name]', with: 'Name of requirement'
    fill_in 'requirement[description]', with: 'description of requirement'
    fill_in 'requirement[path]', with: 'http://pagina_path.php'

    click_on I18n.t('dashboard.requirements.form.create_requirements')
    visit dashboard_requirements_path
    expect(page).to have_content 'Name of requirement'
  end
end
