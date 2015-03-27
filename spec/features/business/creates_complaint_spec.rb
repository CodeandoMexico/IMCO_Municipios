require 'rails_helper'

feature 'A business enters the inspections view' do
  attr_reader :municipio, :user, :user_with_complete_profile

  before do
    @municipio = create :municipio
    @user = create :user
    @user_with_complete_profile = create :user, :with_profile
  end

  scenario 'and creates a new complaint without a user logged in' do
    visit municipio_inspections_path(municipio)
    click_on I18n.t('inspections.index.complaint')

    # should redirect us to the users controller view and tell us
    # that we need to login, so that we can post a new complaint
    expect(page).to have_content I18n.t('devise.sessions.user.session_needed_to_continue')
    expect(current_path).to eq new_user_path
  end

  scenario 'and creates a new complaint with a user logged in WITHOUT a complete profile' do
    # sign in user
    sign_in(user)

    # go to the city new complaint section
    visit new_municipio_complaint_path(municipio)

    expect(page).to have_content I18n.t('flash.complaints.you_need_to_complete_your_profile')
    expect(current_path).to eq edit_user_path(user)
  end

  scenario 'and creates a new complaint with a user logged in WITH a complete profile' do
    expect(ActionMailer::Base.deliveries.count).to eq 0
    # sign in user
    sign_in(user_with_complete_profile)

    # go to the city new complaint section
    visit new_municipio_complaint_path(municipio)

    # choose an option for the complaint
    choose(COMPLAINTS['regulation_violation'])
    # create a new complaint
    click_on I18n.t('complaints.new.save_button')

    # check for deliveries to eq
    expect(ActionMailer::Base.deliveries.count).to eq 2

    # get both emails to validate for correctness
    business_email = ActionMailer::Base.deliveries.first
    city_email = ActionMailer::Base.deliveries.second

    # verify content for the business email
    expect(business_email.from).to eq ["notificaciones@minegocio.mx"]
    expect(business_email.subject).to eq I18n.t('correos.empresa.subject')
    expect(business_email.body).to have_content "La denuncia de tu empresa ha sido enviada al municipio #{municipio.nombre}"

    # verify content for the city email
    expect(city_email.from).to eq ["notificaciones@minegocio.mx"]
    expect(city_email.subject).to eq I18n.t('correos.municipio.subject')
    expect(city_email.body).to have_content "Tu municipio ha recibido una denuncia de inspección por la razón #{COMPLAINTS['regulation_violation']}"
  end
end
