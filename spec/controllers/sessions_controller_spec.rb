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
    let(:status) { false }

    before do
      allow_any_instance_of(UserPerformer).to receive(:perform)
        .and_return([status, {user_email: email, user_id: user.id}, {}])
      post :create, params: { user: user_params }
    end

    context 'when created unsuccessful' do
      specify do
        expect(response).to render_template('pages/index')
        expect(controller.session[:user_id]).to eq nil
        expect(controller.session[:user_email]).to eq nil
        expect(response.response_code).to eq 200
      end
    end

    context 'when created successfully' do
      let(:status) { true }

      specify do
        expect(controller.session[:user_id]).to eq user.id
        expect(controller.session[:user_email]).to eq email
        expect(response).to redirect_to root_path
        expect(response.response_code).to eq 302
      end
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
