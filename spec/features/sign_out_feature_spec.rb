require 'rails_helper'

RSpec.describe "Projects", type: :feature do

  before { sign_in }

  scenario "User signed out" do
    find('.toast-title').click
    click_link I18n.t('session.sign_out')
    expect(page).to have_content 'Bye!'
  end

end
