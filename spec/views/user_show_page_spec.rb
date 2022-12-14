require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    @oluyemi = User.create(name: 'oluyemi', photo: 'Photo', bio: 'Hello World, I am oluyemi')
    (1..5).each do |id|
      Post.create(
        title: "Post #{id}",
        text: 'Hello World, I am oluyemi',
        author_id: @oluyemi.id
      )
    end
    visit user_path(@oluyemi)
  end

  it 'shows the username' do
    expect(page).to have_content(@oluyemi.name)
  end

  it 'shows the users\' bio' do
    expect(page).to have_content(@oluyemi.bio)
  end

  it 'shows the user\'s photo' do
    image = page.all('img')
    expect(image.size).to eql(1)
  end

  it 'shows the user\'s post counter' do
    expect(page).to have_content('Number of posts: 5')
  end

  it 'shows the user\'s last 3 posts' do
    expect(page).to have_content('Post 5')
    expect(page).to have_content('Post 4')
    expect(page).to have_content('Post 3')
  end

  it 'redirects to the posts show page when a post is clicked' do
    click_on 'Post 5'
    expect(page).to have_current_path user_post_path(@oluyemi, @oluyemi.posts.last)
    expect(page).to have_content('Hello World, I am oluyemi')
  end

  it 'has a see all posts link' do
    expect(page).to have_link('See all posts')
  end

  it 'see all posts links to the post index page' do
    first(:link, 'See all posts').click
    expect(page).to have_current_path user_posts_path(@oluyemi)
    expect(page).to have_content('Post 5')
  end
end