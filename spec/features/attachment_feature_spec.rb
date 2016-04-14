require 'rails_helper'

RSpec.describe "Attachment", type: :feature do

  before { sign_in }

  scenario "User add new attachment" do
    project = create(:project, title: 'Hello Capybara', user_id: @user.id)
    create(:task, title: 'Task 1', project_id: project.id)
    file = create(:attachment)
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content 'Task 1'

    find("tbody > tr").hover
    find(".task-comment").click
    fill_in 'comment-textarea', with: 'Comment'
    attach_file_script
    click_button I18n.t('comments.add_comment')

    expect(page).to have_content 'Comment'
    expect(page).to have_content 'lorem.txt'
  end

  scenario "User delete loaded attachment" do
    project = create(:project, title: 'Hello Capybara', user_id: @user.id)
    create(:task, title: 'Task 1', project_id: project.id)
    file = create(:attachment)
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content 'Hello Capybara'
    expect(page).to have_content 'Task 1'

    find("tbody > tr").hover
    find(".task-comment").click
    fill_in 'comment-textarea', with: 'Comment'
    attach_file_script
    click_button I18n.t('comments.add_comment')
    find(".times").click

    expect(page).to have_content 'Comment'
    expect(page).not_to have_content 'lorem.txt'
  end
end
