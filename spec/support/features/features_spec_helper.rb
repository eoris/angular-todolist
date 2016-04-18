def sign_in
  @user = create(:user)
  visit root_path
  fill_in 'login-username', with: @user.email
  fill_in 'login-password', with: @user.password
  click_button I18n.t('session.login')
end
