require 'rails_helper'

RSpec.feature "Sign In", js: true do

  let(:user) { create(:user) }

  scenario "User sign in successfully via sign in form if registered" do
    visit root_path

    expect(page).to have_content I18n.t('session.sign_in')
    expect(page).to have_content I18n.t('session.login')
    expect(page).to have_content I18n.t('session.facebook')
    expect(page).to have_content I18n.t('session.no_account')
    expect(page).to have_content I18n.t('session.sign_up_here')

    fill_in 'login-username', with: user.email
    fill_in 'login-password', with: user.password

    click_button I18n.t('session.login')
    expect(page).not_to have_content I18n.t('session.sign_in')
    expect(page).to have_content I18n.t('projects.add_todo_list')
  end

  scenario "User sign in unsuccessfully via sign in form if unregistered" do
    visit root_path

    fill_in 'login-username', with: 'exemple@test.cpm'
    fill_in 'login-password', with: '12345678'

    click_button I18n.t('session.login')
    expect(page).to have_content 'Invalid credentials'
  end
end
