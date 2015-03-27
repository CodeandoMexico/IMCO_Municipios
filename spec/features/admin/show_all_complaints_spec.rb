require 'rails_helper'

feature 'show all complaints' do
  attr_reader :admin, :user, :complaint

  before do
    @user = create :admin
  end

  scenario 'and all the information exists' do
    create_new_complaint( fill_new_complaint)
    sign_in user
    visit dashboard_path(user)

    click_on I18n.t('navbar.denuncia')

    expect(page).to have_content COMPLAINTS[complaint.reason]
  end

 scenario 'and show specific complaint' do
    create_new_complaint(fill_new_complaint)
    sign_in user
    visit dashboard_path(user)
    click_on I18n.t('navbar.denuncia')

    click_on I18n.t('form.actions.show')
    expect(page).to have_content user.email
    expect(page).to have_content COMPLAINTS[complaint.reason]
    expect(page).to have_content complaint.description

    click_on I18n.t('dashboard.reports.show.licencia_de_operacion')
 end

  def fill_new_complaint
     new_complaint_info = {
           reason: "regulation_violation",
           description: "descripcion_prueba",
           municipio_id: user.municipio_id,
           custom_reason: "",
           user_id: user.id
      }
  end

  def create_new_complaint(args)
     @complaint =  Complaint.create(
                    :reason => args.fetch(:reason),
                    :description => args.fetch(:description),
                    :municipio_id => args.fetch(:municipio_id),
                    :custom_reason => args.fetch(:custom_reason),
                    :user_id => args.fetch(:user_id)
                   )
  end
end
