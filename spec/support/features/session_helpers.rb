module SessionHelpers
  def sign_in_admin(admin)
    visit dashboard_path
    fill_in 'user_email', with: admin.email
    fill_in 'user_password', with: admin.password
    click_on 'Entrar'
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Entrar'
  end

  def sign_out(user)
    visit root_path
    click_on 'Salir'
  end
end
