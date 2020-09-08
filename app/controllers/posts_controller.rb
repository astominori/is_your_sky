class PostsController < ApplicationController
  def index
    @posts = Post.find_by(user_id: session[:user_id])
    @posts = @posts.page(params[:page]).per(10)
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to user_path
    else
      render "new"
  end

  private
  def post_params
    params.require(:post).permit(:img, :text, :user_id)
  end
end
