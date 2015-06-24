require 'rails_helper'

feature 'validate Formation_Steps' do
  attr_reader :admin

  before do
    @admin = create :admin
  end

  scenario 'and validate the insert of formation steps' do
    sign_in admin
    visit dashboard_path(admin)
    click_on I18n.t('dashboard.menu.formation_steps')
    create_formation_step
  end

  scenario 'and edit formation step' do
    sign_in admin
    visit dashboard_path(admin)
    click_on I18n.t('dashboard.menu.formation_steps')
    create_formation_step
    edit_formation_step
  end


  def edit_formation_step
     visit edit_dashboard_formation_step_path(FormationStep.last)
    fill_in 'formation_step[name]', with: 'new name of formation step'
    fill_in 'formation_step[description]', with: 'description of formation step'
    fill_in 'formation_step[path]', with: 'http://pagina_path.php'
    select 'AM', from: "formation_step[type_formation_step]"

    click_on I18n.t('dashboard.formation_steps.form.create_formation_steps')
    visit dashboard_formation_steps_path
    expect(page).to have_content 'new name of formation step'
    expect(page).to have_content 'Moral'
  end

  def create_formation_step
    click_on I18n.t('dashboard.formation_steps.index.new_formation_step')
    
    fill_in 'formation_step[name]', with: 'Name of formation step'
    fill_in 'formation_step[description]', with: 'description of formation step'
    fill_in 'formation_step[path]', with: 'http://pagina_path.php'
    select 'AF', from: "formation_step[type_formation_step]"
    click_on I18n.t('dashboard.formation_steps.form.create_formation_steps')
    visit dashboard_formation_steps_path
    expect(page).to have_content('Name of formation step')
  end
end
