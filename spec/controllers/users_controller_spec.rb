require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'should return 200 success' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'should render the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'should render the correct text in the template' do
      get users_path
      expect(response.body).to include('This is the Users index page.')
    end
  end