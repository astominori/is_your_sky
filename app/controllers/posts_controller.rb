class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit,:update,:destroy,:show]

  def index
  end

  def new
    @post = current_user.posts.build(flash[:post])
    if params[:back].present?
      params[:back] = user_root_path
    end
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
  end

  def update
    if @post.update(post_params)
      redirect_to user_root_path
    else
      redirect_back fallback_location: root_path, flash: {
        post: @post,
        error_messages: @post.errors.full_messages
      }
    end
  end

  def destroy
  end

  def show
  end

  private
  def post_params
    params.require(:post).permit(:image, :text, :title, :image_cache, :remove_image)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

end
