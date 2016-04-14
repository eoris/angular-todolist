require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  before do
    sign_in user
    setup_ability
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
    context 'when params are valid' do
      it 'save new task' do
        task = attributes_for(:task)
        expect { post :create, format: :json,
          project_id: project.id, title: task[:title], deadline: task[:deadline]}.
          to change(Task, :count).by(1)
      end
    end

    context 'when params are invalid' do
      it 'does not create task' do
        expect { post :create, format: :json, project_id: project.id, title: '', deadline: ''}.
          to_not change(Task, :count)
      end

      it 'render errors' do
        post :create, format: :json, project_id: project.id, title: '', deadline: ''
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq(["Title can't be blank"])
      end
    end

    it 'not authorized' do
      @ability.cannot :manage, Task
      post :create, format: :json, project_id: project.id
      expect(response).to be_forbidden
    end
  end

  describe "PATCH #update" do
    context 'when params are valid' do
      it 'updates task' do
        patch :update, format: :json, id: task.id, title: 'title'
        expect(task.reload.title).to eq('title')
      end
    end

    context 'when params are invalid' do

      before { patch :update, format: :json, id: task.id, title: '' }

      it 'does not update task' do
        expect(task.title).to eq(task.reload.title)
      end

      it 'render errors' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq(["Title can't be blank"])
      end
    end

    it 'not authorized' do
      @ability.cannot :manage, Task
      patch :update, format: :json, id: task.id
      expect(response).to be_forbidden
    end
  end

  describe "DELETE #destroy" do
    it 'destroy task' do
      task = create(:task)
      expect { delete :destroy, format: :json, id: task.id }.to change(Task, :count).by(-1)
    end

    it 'not authorized' do
      @ability.cannot :manage, Task
      delete :destroy, format: :json, id: task.id
      expect(response).to be_forbidden
    end
  end
end
