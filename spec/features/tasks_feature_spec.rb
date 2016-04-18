require 'rails_helper'

RSpec.feature "Tasks", js: true do

  let(:project) { create(:project, user: @user) }
  let(:task)    { create(:task, project: project) }
  let(:task1)   { create(:task, deadline: '', project: project) }

  before do
    sign_in_auth
    project
    task
  end

  scenario "User add new task" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')

    fill_in 'task-title-input', with: 'Task 1'
    click_button I18n.t('projects.add_task')

    expect(page).to have_content 'Task 1'
  end

  scenario "User update task state" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title

    find("input[type='checkbox']").click

    expect(page).to have_css('.label-success')
  end

  scenario "User update task date" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title
    expect(page).to have_content '04-04-2016'

    find("tbody > tr").hover
    find(".task-edit-date").click
    find('.day', :text => '15').click

    expect(page).to have_css '.label-warning'
    expect(page).not_to have_content '04-04-2016'
    expect(page).to have_content '15-04-2016'
  end

  scenario "User update task title" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title

    find("tbody > tr").hover
    find(".task-edit").click
    fill_in 'edit-task-title-input', with: 'There is no task'
    find('.edit-task-title-submit').click

    expect(page).not_to have_content 'Task 1'
    expect(page).to have_content 'There is no task'
  end

  scenario "User delete task" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title

    find("tbody > tr").hover
    find(".task-delete").click

    expect(page).not_to have_content 'Task 1'
  end
end
