require 'rails_helper'

feature 'validate Dependency' do
  attr_reader :admin

  before do
    @admin = create :admin
  end

  scenario 'and validate the insert of dependencies' do
    sign_in admin
    visit dashboard_path(admin)
    click_on I18n.t('dashboard.menu.dependencies')
    create_dependency
  end

   scenario 'and edit dependency' do
     sign_in admin
     visit dashboard_path(admin)
     click_on I18n.t('dashboard.menu.dependencies')
     create_dependency
     edit_dependency
   end


  def edit_dependency
    visit edit_dashboard_dependency_path(Dependency.last)
    fill_in 'dependency[name]', with: 'new name of dependency'
    click_on I18n.t('dashboard.dependencies.form.create_dependency')
    visit dashboard_dependencies_path
    expect(page).to have_content 'new name of dependency'
  end

  def create_dependency
    click_on I18n.t('dashboard.dependencies.index.new_dependency')
    fill_in 'dependency[name]', with: 'Name of dependency'
    click_on I18n.t('dashboard.dependencies.form.create_dependency')
    visit dashboard_dependencies_path
    expect(page).to have_text('Name of dependency')
    #save_and_open_page
  end
end
