require 'rails_helper'

describe MoviesController, type: :controller do
  let!(:user) { create(:user)}

  describe 'GET #new' do
    context 'when user not yet logged in' do
      before { get :new }

      specify do
        expect(response.response_code).to eq 302
        expect(response).to redirect_to root_path
      end
    end

    context 'when user logged in' do
      before do
        controller.session[:user_id] = user.id
        controller.session[:user_email] = user.email
        get :new 
      end

      specify do
        expect(response.response_code).to eq 200
        expect(response).to render_template('movies/new')
      end
    end
  end

  describe 'POST #create' do
    let(:movie_params) { { youtube_url: 'http://www.youtube.com/watch?v=123456'} }

    context 'when user not yet logged in' do
      before { post :create, params: { movie: movie_params } }

      specify do
        expect(response.response_code).to eq 302
        expect(response).to redirect_to root_path
      end
    end

    context 'when user logged in' do
      before do
        controller.session[:user_id] = user.id
        controller.session[:user_email] = user.email
      end

      context 'and create movie is successful' do
        before do
          allow_any_instance_of(MovieCreator).to receive(:perform)
            .and_return([true, {success: 'Movie was successfully created.'}])
          post :create, params: { movie: movie_params }
        end

        specify do
          expect(response).to redirect_to root_path
        end
      end

      context 'and create movie is unsuccessful' do
        before do
          allow_any_instance_of(MovieCreator).to receive(:perform)
            .and_return([false, {danger: 'Video is not available'}])
          post :create, params: { movie: movie_params }
        end

        specify do
          expect(response.response_code).to eq 200
          expect(response).to render_template('movies/new')
        end
      end
    end
  end
end
