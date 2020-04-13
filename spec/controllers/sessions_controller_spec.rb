require 'rails_helper'

describe SessionsController, type: :controller do
  let(:email) { 'chid@example.com' }
  let(:password) { '12345678' }
  let!(:user) { create(:user, email: email, password: password)}

  describe '#create' do
    let(:user_params) do
      {
        email: email,
        password: password
      }
    end

    before do
      allow_any_instance_of(UserPerformer).to receive(:perform)
        .and_return([{user_email: email, user_id: user.id}, {}])
      post :create, params: { user: user_params }
    end

    specify do
      expect(controller.session[:user_id]).to eq user.id
      expect(controller.session[:user_email]).to eq email
      expect(response).to redirect_to root_path
    end
  end

  describe '#destroy' do
    before do
      controller.session[:user_id] = user.id
      controller.session[:user_email] = email
    end

    specify do
      delete :destroy
      expect(controller.session[:user_id]).to eq nil
      expect(controller.session[:user_email]).to eq nil
      expect(response).to redirect_to root_path
    end
  end
end
