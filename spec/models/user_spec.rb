require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'Aaron', photo: 'photo', bio: 'Hey folks!', post_counter: 0)
    @user.save
  end

  describe 'User Model Properties' do
    it 'name should be present' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'should have a photo' do
      @user.photo = 'photo'
      expect(@user).to be_valid
    end

    it 'should have a bio' do
      @user.bio = 'bio'
      expect(@user).to be_valid
    end

    it 'post_counter should be greater than or equal to 0' do
      @user.post_counter = nil
      expect(@user).to_not be_valid
    end
  end

  describe 'User Model Methods' do
    before do
      5.times do |n|
        Post.create(title: "Post #{n}", author_id: @user.id, comments_counter: 0, likes_counter: 0)
      end
    end

    it 'should have a last_3_posts method' do
      expect(@user).to respond_to(:last_3_posts)
    end

    it 'should return the last 3 posts' do
      expect(@user.last_3_posts.count).to eq(3)
    end
  end
end
