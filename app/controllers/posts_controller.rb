class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @user = current_user
    @post = @user.posts.build(flash[:post])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to user_root_path
    else
      redirect_back fallback_location: root_path, flash: {
        post: @post,
        error_messages: @post.errors.full_messages
      }
    end
  end

  def edit
    @user = current_user
    @post = @user.posts.find_by(params[:post])
  end

  def update
    if @post.update!(task_params)
      redirect_to user_root_path
    else
      redirect_back fallback_location: root_path, flash: {
        post: @post,
        error_messages: @post.errors.full_messages
      }
    end
  end

  private
  def post_params
    params.require(:post).permit(:image, :text, :title)
  end
end
