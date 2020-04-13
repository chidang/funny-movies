require 'rails_helper'

describe MoviesController, type: :controller do
  describe 'GET #new' do
    before { get :new }

    specify do
      expect(response.response_code).to eq 200
      expect(response).to render_template('movies/new')
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }

    let(:movie_params) { { youtube_url: 'http://www.youtube.com/watch?v=123456'} }

    context 'when create movie is successful' do
      before do
        allow_any_instance_of(MovieCreator).to receive(:perform)
          .and_return([true, {success: 'Movie was successfully created.'}])
        post :create, params: { movie: movie_params }
      end

      specify do
        expect(response).to redirect_to root_path
      end
    end

    context 'when create movie is unsuccessful' do
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
