require 'rails_helper'

RSpec.describe "Projects", type: :feature do

  before { sign_in }

  scenario "User add new project" do
    expect(page).to have_content I18n.t('projects.add_todo_list')

    click_button I18n.t('projects.add_todo_list')
    fill_in 'add-todo-input', with: 'Hello Capybara'
    click_button 'add-todo-button'

    expect(page).to have_content 'Hello Capybara'
  end

  scenario "User update project" do
    create(:project, title: 'Hello Capybara', user_id: @user.id)
    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content I18n.t('projects.add_todo_list')

    find(".panel-heading").hover
    find(".project-edit").click
    fill_in 'edit-project-input', with: 'Hello Angular'
    click_button "update-project-button"

    expect(page).not_to have_content 'Hello Capybara'
    expect(page).to have_content 'Hello Angular'
  end

  scenario "User delete project" do
    create(:project, title: 'Hello Capybara', user_id: @user.id)
    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content I18n.t('projects.add_todo_list')

    find(".panel-heading").hover
    find(".project-delete").click

    expect(page).not_to have_content 'Hello Capybara'
  end
end
