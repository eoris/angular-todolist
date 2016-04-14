require 'rails_helper'

RSpec.describe "Projects", type: :feature do

  before do
    @user = create(:user)
    visit root_path
    fill_in 'login-username', with: @user.email
    fill_in 'login-password', with: @user.password
    click_button I18n.t('session.login')
  end

  scenario "User signed out" do
    find('.toast-title').click
    click_link I18n.t('session.sign_out')
    expect(page).to have_content 'Bye!'
  end

end
