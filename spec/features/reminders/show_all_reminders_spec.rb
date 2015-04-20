require 'rails_helper'

feature 'show all reminders' do
  attr_reader  :user, :reminders, :city, :municipio

  before do
    @user =  create :user
  end

  scenario 'and create a new reminder' do

   create_reminder
 end

 scenario 'and   we show you all  reminders' do

  create_reminder

  expect(page).to have_content I18n.t('titles.reminder')

  expect(page).to have_content 'Licencia de uso de suelo'
  expect(page).to have_content '234567sdfghj'
  expect(page).to have_content '2015-04-16'
  expect(page).to have_content I18n.t('reminders.index.edit')
  expect(page).to have_content I18n.t('reminders.index.borrar')
end

scenario 'and   edit a  reminder' do

  create_reminder

  expect(page).to have_content I18n.t('titles.reminder')

  expect(page).to have_content 'Licencia de uso de suelo'
  expect(page).to have_content '234567sdfghj'
  expect(page).to have_content '2015-04-16'
  expect(page).to have_content I18n.t('reminders.index.edit')
  expect(page).to have_content I18n.t('reminders.index.borrar')

  click_on I18n.t('reminders.index.edit')

  expect(page).to have_content I18n.t('titles.edit_reminder')
  fill_in 'reminders[name]', with: 'Documento importante'
  click_on I18n.t('reminders.index.create_reminder')

  expect(page).to have_content 'Documento importante'
end

def fill_new_user
  new_user_info = {
    name: 'Mi Nombre',
    address: 'This is a fake address',
    business_name: 'This is a business name',
    operation_license: 'AN49FN40865J'
  }
end

def update_user(args)
  fill_in 'user[name]', with: args.fetch(:name)  
  fill_in 'user[address]', with: args.fetch(:address)
  fill_in 'user[business_name]', with: args.fetch(:business_name)
  fill_in 'user[operation_license]',  with: args.fetch(:operation_license)
  
  click_on I18n.t('users.edit.save')
#  user.update(
  #  :address => args.fetch(:address),
   # :business_name => args.fetch(:business_name),
    #:operation_license => args.fetch(:operation_license)
    #)
end

def create_reminder
  sign_in user
  

#  save_and_open_page
  visit city_inspections_path(user.city)


  click_on I18n.t('inspections.index.recordatorios')

  update_user(fill_new_user)

  click_on I18n.t('inspections.index.recordatorios')
  
  #fill all text_fields
  #expect(page).to have_content I18n.t('reminders.index.new_reminder')
  fill_in 'reminders[name]', with: 'Licencia de uso de suelo'
  fill_in 'reminders[license]', with: '234567sdfghj'
  fill_in 'reminders[until_to]', with: '04/16/2015'
  
  click_on I18n.t('reminders.index.create_reminder')
end
end
