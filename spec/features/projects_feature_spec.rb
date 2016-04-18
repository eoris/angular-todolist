require 'rails_helper'

RSpec.feature "Projects", js: true do

  let(:project) { create(:project, user: @user) }
  let(:task)    { create(:task, project: project) }

  before do
    sign_in_auth
    project
    task
  end

  scenario "User add new project" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')

    click_button I18n.t('projects.add_todo_list')
    fill_in 'add-todo-input', with: 'Hello Capybara'
    click_button 'add-todo-button'

    expect(page).to have_content 'Hello Capybara'
  end

  scenario "User update project" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title

    find(".panel-heading").hover
    find(".project-edit").click
    fill_in 'edit-project-input', with: 'Hello Angular'
    click_button "update-project-button"

    expect(page).not_to have_content 'Hello Capybara'
    expect(page).to have_content 'Hello Angular'
  end

  scenario "User delete project" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title

    find(".panel-heading").hover
    find(".project-delete").click

    expect(page).not_to have_content 'Hello Capybara'
  end
end
