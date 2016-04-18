def sign_in_auth
  @user = create(:user)
  auth_headers = @user.create_new_auth_token
  # Uncomment for selenium driver
  # visit root_path
  page.driver.set_cookie('auth_headers', auth_headers.to_json)
end
