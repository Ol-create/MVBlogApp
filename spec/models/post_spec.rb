require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.new(name: 'Aaron', photo: 'photo', bio: 'Hey folks!', post_counter: 0)
    @user.save
    @post = Post.new(author: @user, title: 'Post 1', text: 'text 1', comments_counter: 0, likes_counter: 0)
    @post.save
  end

  describe 'Post Model Properties' do
    it 'title should be present' do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'author_id should be present' do
      @post.author = nil
      expect(@post).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to 0' do
      @post.comments_counter = nil
      expect(@post).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to 0' do
      @post.likes_counter = nil
      expect(@post).to_not be_valid
    end
  end

  describe 'Post Model Methods' do
    before do
      5.times do |n|
        Comment.create(post: @post, author: @user, text: "Comment #{n}")
      end
    end

    it 'should have a last_5_comments method' do
      expect(@post).to respond_to(:last_5_comments)
    end

    it 'should return the last 5 comments' do
      expect(@post.last_5_comments.count).to eq(5)
    end
  end
end
