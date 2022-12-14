class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create delete]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:author)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(posts_params)
    @post.author = current_user
    if @post.save
      flash[:notice] = 'Post published succesfully'
      redirect_to user_post_path(current_user, @post)
    else
      flash[:error] = @post.errors.full_messages[0]
      render :new
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :text)
  end
end