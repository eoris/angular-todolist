require 'rails_helper'

RSpec.feature "Comment", js: true do

  let(:project) { create(:project, user: @user) }
  let(:task)    { create(:task, project: project) }
  let(:comment) { create(:comment, task: task) }

  before do
    sign_in_auth
    project
    task
    comment
  end

  scenario "User add new comment" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title

    find("tbody > tr").hover
    find(".task-comment").click
    fill_in 'comment-textarea', with: 'Comment'
    click_button I18n.t('comments.add_comment')

    expect(page).to have_content 'Comment'
  end

  scenario "User add invalid comment" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title

    find("tbody > tr").hover
    find(".task-comment").click
    click_button I18n.t('comments.add_comment')

    expect(page).to have_content "Text can't be blank"
  end

  scenario "User delete comment" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title

    find("tbody > tr").hover
    find(".task-comment").click
    expect(page).to have_content comment.text
    find('.delete-comment-button').click

    expect(page).not_to have_content 'Comment'
  end
end
