require 'rails_helper'

RSpec.feature "Sign Up", js: true do

  scenario "User sign up successfully" do
    visit root_path
    click_link(I18n.t('session.sign_up_here'))

    expect(page).to have_content I18n.t('registration.sign_up')
    expect(page).to have_content I18n.t('registration.email')
    expect(page).to have_content I18n.t('registration.password')
    expect(page).to have_content I18n.t('registration.sign_up')
    expect(page).to have_content I18n.t('registration.or')

    fill_in 'registration-email',             with: 'exemple@test.com'
    fill_in 'registration-password',          with: '12345678'
    fill_in 'confirm-registration-password',  with: '12345678'
    click_button I18n.t('registration.sign_up')

    expect(page).not_to have_content I18n.t('registration.sign_up')
    expect(page).to have_content I18n.t('projects.add_todo_list')
  end

  scenario "User sign up unsuccessfully" do
    visit root_path
    click_link(I18n.t('session.sign_up_here'))

    expect(page).to have_content I18n.t('registration.sign_up')
    expect(page).to have_content I18n.t('registration.email')
    expect(page).to have_content I18n.t('registration.password')
    expect(page).to have_content I18n.t('registration.sign_up')
    expect(page).to have_content I18n.t('registration.or')

    fill_in 'registration-email',             with: 'exemple@test'
    fill_in 'registration-password',          with: '123456789'
    fill_in 'confirm-registration-password',  with: '12345678'
    click_button I18n.t('registration.sign_up')

    expect(page).not_to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(page).to have_content 'Email is not an email'
  end
end
