require 'rails_helper'

feature 'show all components' do
  attr_reader :admin, :complaint

  before do
    @admin = create :admin
  end

  scenario 'and all of them exists' do
    sign_in admin

    visit dashboard_path(admin)

    expect(page).to have_content I18n.t('dashboard.show.dependencias')
    expect(page).to have_content I18n.t('dashboard.show.giros')
    expect(page).to have_content I18n.t('dashboard.show.apertura')
    expect(page).to have_content I18n.t('dashboard.show.requerimientos')
    expect(page).to have_content I18n.t('dashboard.show.inspecciones')
    expect(page).to have_content I18n.t('dashboard.show.inspectores')
    expect(page).to have_content I18n.t('dashboard.show.denuncia')
  end

  scenario 'and validate the insert of lines' do
    sign_in admin

    visit dashboard_path(admin)
    click_on I18n.t('dashboard.show.giros')
    
    create_line

    
  end

  scenario 'and edit line' do
    sign_in admin

    visit dashboard_path(admin)
    click_on I18n.t('dashboard.show.giros')
    
    create_line
    
    edit_line

  end


  def edit_line
    visit dashboard_lines_path
    click_on I18n.t('form.actions.edit')
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
