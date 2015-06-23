require 'rails_helper'

feature 'show all components' do
  attr_reader :admin

  before do
    @admin = create :admin
  end

  scenario 'and all of them exists' do
    sign_in admin

    visit dashboard_path(admin)

    expect(page).to have_content I18n.t('dashboard.menu.dependencies')
    expect(page).to have_content I18n.t('dashboard.menu.lines')
    expect(page).to have_content I18n.t('dashboard.menu.formation_steps')
    expect(page).to have_content I18n.t('dashboard.menu.requirements')
    expect(page).to have_content I18n.t('dashboard.menu.inspections')
    expect(page).to have_content I18n.t('dashboard.menu.inspectors')
    expect(page).to have_content I18n.t('dashboard.menu.complaints')
    expect(page).to have_content I18n.t('dashboard.menu.procedures')
  end

  scenario 'and validate the insert of lines' do
    sign_in admin

    visit dashboard_path(admin)
    click_on I18n.t('dashboard.menu.lines')
    
    create_line    
  end

  scenario 'and edit line' do
    sign_in admin

    visit dashboard_path(admin)
    click_on I18n.t('dashboard.menu.lines')
    
    create_line

    edit_line
  end

  def edit_line
    visit edit_dashboard_line_path(Line.where(name: 'Name of line').last)
    fill_in 'line[name]', with: 'new name of line'
    click_on I18n.t('dashboard.lines.form.create_lines')
    visit dashboard_lines_path
    expect(page).to have_content 'new name of line'
  end

  def create_line
    click_on I18n.t('dashboard.lines.index.new_lines')
    fill_in 'line[name]', with: 'Name of line'
    fill_in 'line[description]', with: 'This is a description'
    click_on I18n.t('dashboard.lines.form.create_lines')
    visit dashboard_lines_path
    expect(page).to have_content 'Name of line'
    expect(page).to have_content admin.city_id
  end
end
