class PostsController < ApplicationController
  def index
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to user_path(current_user)
    else
      render "new"
    end
  end

  private
  def post_params
    params.require(:post).permit(:image, :text, :title)
  end
end
