class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit,:update,:destroy]

  def index
  end

  def new
    @post = current_user.posts.build
    if params[:back].present?
      params[:back] = user_root_path
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    unless params[:tag_list].nil?
      tag_list = params[:tag_list].split(",")
    end
    if @post.save
      @post.save_tags(tag_list) if tag_list
      flash[:notice] = "投稿しました"
      redirect_to user_root_path
    else
      render "new"
    end
  end

  def edit
    @tag_list = @post.tags.pluck(:tag).join(",")
  end

  def update
    unless params[:tag_list].nil?
      tag_list = params[:tag_list].split(",")
    end
    if @post.update(post_params)
      @post.save_tags(tags) if tag_list
      flash[:notice] = "更新が完了しました"
      redirect_to user_root_path
    else
      render "new"
    end
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
  end

  def todays_posts
    @todays_posts = Post.created_today
  end

  private
  def post_params
    params.require(:post).permit(:image, :text, :title, :image_cache, :remove_image )
  end

  def set_post
    begin
      @post = current_user.posts.find(params[:id])
    rescue => e
      logger.error e
      flash[:alert] = "アクセスができない画面です"
      redirect_to user_root_path
    end
  end
end
