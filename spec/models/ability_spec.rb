require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do

  describe "not authorized user" do
    let(:user)       { nil }
    let(:ability)    { Ability.new(user) }
    let(:project)    { create(:project) }
    let(:task)       { create(:task) }
    let(:comment)    { create(:comment) }
    let(:attachment) { create(:attachment) }

    it { expect(ability).not_to be_able_to(:manage, :all) }

    context 'cannot manage project' do
      it { expect(ability).not_to be_able_to(:create, Project) }
      it { expect(ability).not_to be_able_to(:index, project) }
      it { expect(ability).not_to be_able_to(:update, project) }
      it { expect(ability).not_to be_able_to(:destroy, project) }
    end

    context 'cannot manage task' do
      it { expect(ability).not_to be_able_to(:create, Task) }
      it { expect(ability).not_to be_able_to(:update, task) }
      it { expect(ability).not_to be_able_to(:destroy, task) }
    end

    context 'cannot manage comment' do
      it { expect(ability).not_to be_able_to(:create, Comment) }
      it { expect(ability).not_to be_able_to(:destroy, comment) }
    end

    context 'cannot manage comment' do
      it { expect(ability).not_to be_able_to(:create, Attachment) }
      it { expect(ability).not_to be_able_to(:destroy, attachment) }
    end
  end

  describe "authorized user" do
    let(:user)            { create(:user) }
    let(:ability)         { Ability.new(user) }
    let(:user_project)    { create(:project, user_id: user.id) }
    let(:user_task)       { create(:task, project_id: user_project.id) }
    let(:user_comment)    { create(:comment, task_id: user_task.id) }
    let(:user_attachment) { create(:attachment, comment_id: user_comment.id) }

    it { expect(ability).not_to be_able_to(:manage, :all) }

    context 'can manage project' do
      it { expect(ability).to be_able_to(:create, Project) }
      it { expect(ability).to be_able_to(:index, user_project) }
      it { expect(ability).to be_able_to(:update, user_project) }
      it { expect(ability).to be_able_to(:destroy, user_project) }
    end

    context 'can manage task' do
      it { expect(ability).to be_able_to(:create, Task) }
      it { expect(ability).to be_able_to(:update, user_task) }
      it { expect(ability).to be_able_to(:destroy, user_task) }
    end

    context 'can manage comment' do
      it { expect(ability).to be_able_to(:create, Comment) }
      it { expect(ability).to be_able_to(:destroy, user_comment) }
    end

    context 'can manage comment' do
      it { expect(ability).to be_able_to(:create, Attachment) }
      it { expect(ability).to be_able_to(:destroy, user_attachment) }
    end
  end

  describe "authorized other user" do
    let(:user)            { create(:user) }
    let(:other_user)      { create(:user) }
    let(:ability)         { Ability.new(other_user) }
    let(:user_project)    { create(:project, user_id: user.id) }
    let(:user_task)       { create(:task, project_id: user_project.id) }
    let(:user_comment)    { create(:comment, task_id: user_task.id) }
    let(:user_attachment) { create(:attachment, comment_id: user_comment.id) }

    context 'cannot manage project of user' do
      it { expect(ability).not_to be_able_to(:index, user_project) }
      it { expect(ability).not_to be_able_to(:update, user_project) }
      it { expect(ability).not_to be_able_to(:destroy, user_project) }
    end

    context 'cannot manage task of user' do
      it { expect(ability).not_to be_able_to(:update, user_task) }
      it { expect(ability).not_to be_able_to(:destroy, user_task) }
    end

    context 'cannot manage comment of user' do
      it { expect(ability).not_to be_able_to(:destroy, user_comment) }
    end

    context 'cannot manage comment of user' do
      it { expect(ability).not_to be_able_to(:destroy, user_attachment) }
    end
  end

end
