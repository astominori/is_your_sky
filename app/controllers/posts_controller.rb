class PostsController < ApplicationController
  def index
  end

  def new
    @post = current_user.posts.build(flash[:post])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to user_path(current_user)
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
