require 'rails_helper'

RSpec.describe "Tasks", type: :feature do

  before { sign_in }

  scenario "User add new task" do
    create(:project, title: 'Hello Capybara', user_id: @user.id)
    expect(page).to have_content I18n.t('projects.add_todo_list')
    sleep(5)
    expect(page).to have_content 'Hello Capybara'

    fill_in 'task-title-input', with: 'Task 1'
    click_button I18n.t('projects.add_task')

    expect(page).to have_content 'Task 1'
  end

  scenario "User update task state" do
    project = create(:project, title: 'Hello Capybara', user_id: @user.id)
    create(:task, title: 'Task 1', project_id: project.id)

    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content 'Task 1'
    expect(page).to have_content I18n.t('projects.add_todo_list')

    find("input[type='checkbox']").click

    expect(page).to have_css('.label-success')
  end

  scenario "User update task date" do
    project = create(:project, title: 'Hello Capybara', user_id: @user.id)
    create(:task, title: 'Task 1', deadline: '', project_id: project.id)

    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content 'Task 1'
    expect(page).to have_content I18n.t('projects.add_todo_list')

    find("tbody > tr").hover
    find(".task-edit-date").click
    find('.day', :text => '15').click
    find(".task-edit-date").click

    expect(page).to have_css '.label-warning'
  end

  scenario "User update task title" do
    project = create(:project, title: 'Hello Capybara', user_id: @user.id)
    create(:task, title: 'Task 1', project_id: project.id)
    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content 'Task 1'
    expect(page).to have_content I18n.t('projects.add_todo_list')

    find("tbody > tr").hover
    find(".task-edit").click
    fill_in 'edit-task-title-input', with: 'There is no task'
    find('.edit-task-title-submit').click

    expect(page).not_to have_content 'Task 1'
    expect(page).to have_content 'There is no task'
  end

  scenario "User delete task" do
    project = create(:project, title: 'Hello Capybara', user_id: @user.id)
    create(:task, title: 'Task 1', project_id: project.id)
    sleep(2)
    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content 'Task 1'
    expect(page).to have_content I18n.t('projects.add_todo_list')

    find("tbody > tr").hover
    find(".task-delete").click

    expect(page).not_to have_content 'Task 1'
  end
end
