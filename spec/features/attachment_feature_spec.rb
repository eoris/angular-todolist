require 'rails_helper'

RSpec.feature "Attachment", js: true do

  let(:project) { create(:project, user: @user) }
  let(:task)    { create(:task, project: project) }

  before do
    sign_in_auth
    project
    task
  end

  scenario "User add new attachment" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title

    find("tbody > tr").hover
    find(".task-comment").click
    fill_in 'comment-textarea', with: 'Comment'
    page.execute_script("$('input[name=attachment]').css('opacity','1')")
    attach_file('attachment', "#{Rails.root}/spec/fixtures/files/lorem.txt")
    click_button I18n.t('comments.add_comment')

    expect(page).to have_content 'Comment'
    expect(page).to have_content 'lorem.txt'
  end

  scenario "User delete loaded attachment" do
    visit root_path
    expect(page).to have_content I18n.t('projects.add_todo_list')
    expect(page).to have_content project.title
    expect(page).to have_content task.title

    find("tbody > tr").hover
    find(".task-comment").click
    fill_in 'comment-textarea', with: 'Comment'
    page.execute_script("$('input[name=attachment]').css('opacity','1')")
    attach_file('attachment', "#{Rails.root}/spec/fixtures/files/lorem.txt")
    click_button I18n.t('comments.add_comment')
    find(".delete-attachment").click

    expect(page).to have_content 'Comment'
    expect(page).not_to have_content 'lorem.txt'
  end
end
