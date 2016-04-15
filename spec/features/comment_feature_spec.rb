require 'rails_helper'

RSpec.feature "Comment", js: true do

  before { sign_in }

  scenario "User add new comment" do
    project = create(:project, title: 'Hello Capybara', user_id: @user.id)
    create(:task, title: 'Task 1', project_id: project.id)
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content 'Task 1'

    find("tbody > tr").hover
    find(".task-comment").click
    fill_in 'comment-textarea', with: 'Comment'
    click_button I18n.t('comments.add_comment')

    expect(page).to have_content 'Comment'
  end

  scenario "User delete comment" do
    project = create(:project, title: 'Hello Capybara', user_id: @user.id)
    task = create(:task, title: 'Task 1', project_id: project.id)
    create(:comment, text: 'Comment', task_id: task.id)
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content 'Task 1'

    find("tbody > tr").hover
    find(".task-comment").click
    expect(page).to have_content 'Comment'
    find('.delete-comment-button').click

    expect(page).not_to have_content 'Comment'
  end
end
