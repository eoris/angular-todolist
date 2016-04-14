require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let!(:projects) { create_list(:project, 5, user: user) }

  before do
    sign_in user
    setup_ability
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    before { get :index, format: :json }

    it { is_expected.to respond_with(200) }
    it { expect(assigns(:projects)).to match_array(projects) }

    it 'not authorized' do
      @ability.cannot :manage, Project
      get :index, format: :json
      expect(response).to be_forbidden
    end
  end

  describe "POST #create" do
    context 'when params are valid' do
      it 'save new project' do
        post :create, project: attributes_for(:project), format: :json
        expect(assigns(:project)).to_not be_nil
      end
    end

    context 'when params are invalid' do
      it 'does not create project' do
        expect { post :create, format: :json, title: '' }.to_not change(Project, :count)
      end

      it 'render errors' do
        post :create, format: :json, title: ''
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq(["Title can't be blank"])
      end
    end

    it 'not authorized' do
      @ability.cannot :manage, Project
      get :create, format: :json
      expect(response).to be_forbidden
    end
  end

  describe "PATCH #update" do
    context 'when params are valid' do
      it 'updates project' do
        patch :update, format: :json, id: project.id, title: 'title'
        expect(project.reload.title).to eq('title')
      end
    end

    context 'when params are invalid' do

      before { patch :update, format: :json, id: project.id, title: '' }

      it 'does not update project' do
        expect(project.title).to eq(project.reload.title)
      end

      it 'render errors' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq(["Title can't be blank"])
      end
    end

    it 'not authorized' do
      @ability.cannot :manage, Project
      patch :update, format: :json, id: project.id
      expect(response).to be_forbidden
    end
  end

  describe "DELETE #destroy" do
    it 'destroy project' do
      project = create(:project, user: user)
      expect { delete :destroy, format: :json, id: project }.to change(Project, :count).by(-1)
    end

    it 'not authorized' do
      @ability.cannot :manage, Project
      delete :destroy, format: :json, id: project.id
      expect(response).to be_forbidden
    end
  end
end
