require 'rails_helper'

feature 'validate Reports' do
  attr_reader :admin, :user

  before do
    @admin = create :admin
    @user = create :user
  end

  scenario 'and show all reports' do
    sign_in user
    create_report
    sign_out user

    sign_in admin

    visit dashboard_path(admin)
    click_on I18n.t('dashboard.menu.complaints')
end

def fill_new_user
  new_user_info = {
    address: 'This is a fake address',
    business_name: 'This is a business name',
    operation_license: 'AN49FN40865J'
  }
end

def update_user(args)
  user.update(
    :address => args.fetch(:address),
    :business_name => args.fetch(:business_name),
    :operation_license => args.fetch(:operation_license)
    )
end

def create_report
  update_user(fill_new_user)

  visit city_inspections_path(user.city)

  click_on I18n.t('inspections.index.complaint')

  choose('Sellos de clausura improcedentes')
  fill_in 'complaint[description]', with: 'money'
  
 # click_on I18n.t('complaints.new.save_button')
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
end