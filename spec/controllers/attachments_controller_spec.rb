require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  let(:user) { create(:user) }
  let(:comment) { create(:comment) }
  let(:attachment) { create(:attachment, comment: comment) }

  before do
    sign_in user
    setup_ability
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
    context 'when params are valid' do
      it 'save new attachment' do
        attachment = attributes_for(:attachment)
        expect { post :create, format: :json, comment_id: comment.id, file: attachment[:file]}.
          to change(Attachment, :count).by(1)
      end
    end

    context 'when params are invalid' do
      it 'does not create attachment' do
        expect { post :create, format: :json, comment_id: comment.id, file: ''}.
          to_not change(Attachment, :count)
      end

      it 'render errors' do
        post :create, format: :json, comment_id: comment.id, file: ''
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq(["File can't be blank"])
      end
    end

    it 'not authorized' do
      @ability.cannot :manage, Attachment
      post :create, format: :json, comment_id: comment.id
      expect(response).to be_forbidden
    end
  end

  describe "DELETE #destroy" do
    it 'destroy attachment' do
      attachment = create(:attachment)
      expect { delete :destroy, format: :json, id: attachment.id }.to change(Attachment, :count).by(-1)
    end

    it 'not authorized' do
      @ability.cannot :manage, Attachment
      delete :destroy, format: :json, id: attachment.id
      expect(response).to be_forbidden
    end
  end
end
