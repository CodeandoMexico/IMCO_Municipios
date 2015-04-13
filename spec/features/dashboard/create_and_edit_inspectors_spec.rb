require 'rails_helper'

feature 'validate Inspectors' do
  attr_reader :admin

  before do
    @admin = create :admin
  end


  scenario 'and validate the insert of Inspector' do
    sign_in admin


    create_dependency


    visit dashboard_path(admin)
    click_on I18n.t('dashboard.show.inspectores')

   
    create_inspector
  end

  scenario 'and edit Inspector' do
    sign_in admin


    create_dependency
   
    visit dashboard_path(admin)
    click_on I18n.t('dashboard.show.inspectores')
    
    create_inspector
    
    edit_inspector
  end


  def edit_inspector
    visit dashboard_inspectors_path
    click_on I18n.t('form.actions.edit')

    fill_in 'inspector[name]', with: 'new name of inspector'
    fill_in 'inspector[validity]', with: '2016'
    fill_in 'inspector[matter]', with: 'matter of dependency'
    fill_in 'inspector[supervisor]', with: 'Name of Supervisor'
    fill_in 'inspector[contact]', with: 'name of contact'

    click_on I18n.t('dashboard.inspectors.form.create_inspector')
    visit dashboard_inspectors_path
    expect(page).to have_content 'new name of inspector'
  end

  def create_inspector

    click_on I18n.t('dashboard.inspectors.index.new_inspector')
    
    fill_in 'inspector[name]', with: 'name of inspector'
    fill_in 'inspector[validity]', with: '2016'
    fill_in 'inspector[matter]', with: 'matter of dependency'
    fill_in 'inspector[supervisor]', with: 'Name of Supervisor'
    fill_in 'inspector[contact]', with: 'name of contact'
    select "Name of dependency", :from => "inspector[dependency_id]"
    
    click_on I18n.t('dashboard.inspectors.form.create_inspector')
    visit dashboard_inspectors_path
    expect(page).to have_content 'name of inspector'
  end

   def create_dependency
    visit dashboard_dependencies_path
    click_on I18n.t('dashboard.dependencies.index.new_dependency')
    
    fill_in 'dependency[name]', with: 'Name of dependency'
    click_on I18n.t('dashboard.dependencies.form.create_dependency')
    visit dashboard_dependencies_path
    expect(page).to have_content 'Name of dependency'
    visit dashboard_path(admin)
  end
end
