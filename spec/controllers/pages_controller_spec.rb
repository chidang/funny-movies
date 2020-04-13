require 'rails_helper'

describe PagesController do
  let(:movie) { create(:movie) }

  describe 'GET #index' do
    before do
      get :index
    end

    specify do
      expect(response).to render_template('pages/index')
      expect(response.response_code).to eq 200
    end
  end
end
