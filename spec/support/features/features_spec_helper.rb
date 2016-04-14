def sign_in
  @user = create(:user)
  visit root_path
  fill_in 'login-username', with: @user.email
  fill_in 'login-password', with: @user.password
  click_button I18n.t('session.login')
end

def attach_file_script
  page.execute_script <<-JS
    fakeFileInput = window.$('<input/>').attr({ id: 'fileFileInput', type: 'file' }).appendTo('body');
  JS
  page.attach_file('fileFileInput', "#{Rails.root}/spec/fixtures/files/lorem.txt")
  page.execute_script <<-JS
    var scope = angular.element('.attachment').scope();
    scope.files = [fakeFileInput.get(0).files[0]];
  JS
end
