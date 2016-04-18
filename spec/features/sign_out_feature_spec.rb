require 'rails_helper'

RSpec.feature "Sign Out", js: true do

  before { sign_in_auth }

  scenario "User signed out" do
    visit root_path
    click_link I18n.t('session.sign_out')
    expect(page).to have_content 'Bye!'
  end

end
