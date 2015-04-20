require 'rails_helper'

feature 'A business logs in' do
  attr_reader :user

  before do
    @user = create :user
  end

  scenario 'and edits his profile' do
    new_user_info = {
      name: 'New User Name',
      business_name: 'ACME Inc.',
      address: 'Fraccionamiento de los Olivos #1, Nuevo León, México',
      operation_license: 'AN49FN40865J',
      operation_license_file: operation_license_file_path,
      land_permission_file: land_permission_file_path
    }

    sign_in user
    visit edit_user_path(user)

    # let's update the user info and upload some dummy files
    update_user_profile_with(new_user_info)

    # let's validate the information uploaded
    expect(page).to have_content I18n.t('flash.users.updated')
    expect(page).to have_selector ("input[value=\'#{new_user_info.fetch(:name)}\']")
    expect(page).to have_selector ("input[value=\'#{new_user_info.fetch(:business_name)}\']")
    expect(page).to have_content new_user_info.fetch(:address)
    expect(page).to have_selector ("input[value=\'#{new_user_info.fetch(:operation_license)}\']")
    expect(page).to have_content user.operation_license_file_identifier
    expect(page).to have_content user.land_permission_file_identifier
  end

  def update_user_profile_with(args)
    fill_in 'user[name]', with: args.fetch(:name)
    fill_in 'user[business_name]', with: args.fetch(:business_name)
    fill_in 'user[address]', with: args.fetch(:address)
    fill_in 'user[operation_license]', with: args.fetch(:operation_license)
    attach_file 'user[operation_license_file]', args.fetch(:operation_license_file)
    attach_file 'user[land_permission_file]', args.fetch(:land_permission_file)

    click_on I18n.t('users.edit.save')
  end

  def operation_license_file_path
    Rails.root.join('spec/fixtures/operation_license_dummy.pdf')
  end

  def land_permission_file_path
    Rails.root.join('spec/fixtures/land_permission_dummy.pdf')
  end
end
