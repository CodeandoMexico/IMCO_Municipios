module SessionHelpers
  # user based helpers
  def sign_in_admin(admin)
    visit dashboard_path
    fill_in 'user_email', with: admin.email
    fill_in 'user_password', with: admin.password
    click_on 'Entrar'
  end

  def sign_out
    #
  end
end
