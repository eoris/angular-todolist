require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { create(:user) }
  let(:task) { create(:task) }
  let(:comment) { create(:comment, task: task) }

  before do
    sign_in user
    setup_ability
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
    context 'when params are valid' do
      it 'save new comment' do
        comment = attributes_for(:comment)
        expect { post :create, format: :json, task_id: task.id, text: comment[:text]}.
          to change(Comment, :count).by(1)
      end
    end

    context 'when params are invalid' do
      it 'does not create comment' do
        expect { post :create, format: :json, task_id: task.id, text: ''}.
          to_not change(Comment, :count)
      end

      it 'render errors' do
        post :create, format: :json, task_id: task.id, text: ''
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq(["Text can't be blank"])
      end
    end

    it 'not authorized' do
      @ability.cannot :manage, Comment
      post :create, format: :json, task_id: task.id
      expect(response).to be_forbidden
    end
  end

  describe "DELETE #destroy" do
    it 'destroy comment' do
      comment = create(:comment)
      expect { delete :destroy, format: :json, id: comment.id }.to change(Comment, :count).by(-1)
    end

    it 'not authorized' do
      @ability.cannot :manage, Comment
      delete :destroy, format: :json, id: comment.id
      expect(response).to be_forbidden
    end
  end
end
