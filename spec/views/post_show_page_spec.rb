require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  before(:each) do
    @oluyemi = User.create(name: 'oluyemi', photo: 'Photo', bio: 'Hello World, I am oluyemi')
    @post = Post.create(
      title: 'Post 1',
      text: 'Hello World, I am oluyemi',
      author_id: @oluyemi.id
    )
    (1..5).each do |id|
      Comment.create(
        text: "Comment #{id}",
        author_id: @oluyemi.id,
        post_id: @post.id
      )
    end
    visit user_posts_path(@oluyemi)
  end

  it 'shows post\'s title' do
    expect(page).to have_content('Post 1')
  end

  it 'shows the post\'s text' do
    expect(page).to have_content('Hello World, I am oluyemi')
  end

  it 'shows the post\'s number of comments' do
    expect(page).to have_content('Comments 5')
  end

  it 'shows the post\'s number of likes' do
    expect(page).to have_content('Likes 0')
  end

  it 'shows the comment\'s author' do
    expect(page).to have_content('oluyemi')
  end

  it 'shows the comment\'s text' do
    expect(page).to have_content('Comment 5')
  end
end