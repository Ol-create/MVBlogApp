require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before :each do
    @user = User.create(name: 'Oluyemi', photo: 'Photo', bio: 'Hello world')
    @post = @user.posts.create(title: 'Test post', text: 'This is a test', author_id: @user.id)
  end

  describe 'GET /index' do
    before { get user_posts_path(@user, @post) }

    it 'should return 200 success' do
      expect(response).to have_http_status(200)
    end

    it 'should render the index template' do
      expect(response).to render_template(:index)
    end

    it 'should render the correct text in the template' do
      expect(response.body).to include('Test post')
    end
  end

  describe 'GET /show' do
    before { get user_post_path(@user, @post) }

    it 'should return 200 success' do
      expect(response).to have_http_status(200)
    end

    it 'should render the show template' do
      expect(response).to render_template(:show)
    end

    it 'should render the correct text in the template' do
      expect(response.body).to include('This is a test')
    end
  end
end
