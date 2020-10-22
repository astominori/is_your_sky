class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  def check_cache_image
    require "google/cloud/vision"

    # Vision APIの設定
    image_annotator = Google::Cloud::Vision.image_annotator do |config|
      if Rails.env.production?
        config.credentials = JSON.parse(ENV.fetch('GOOGLE_CREDENTIALS'))
      else
        config.credentials = ENV["GOOGLE_APPLICATION_CREDENTIALS"]
      end
    end

    # キャッシュ情報を取得する
    image = params[:image_cache].path
    # キャッシュをVision APIにレスポンスとして渡す。
    response = image_annotator.label_detection image: image

    # labelを配列に入れる
    label_list = []
    response.responses.each do |res|
      res.label_annotations.each do |label|
        label_list.push(label.description)
      end
    end

    # 空の写真かを判定する
    @no_sky_image = !label_list.include?("Sky")

    # labelの先頭3つをタグとして持ってくる
    @tag_list = label_list[0..3]

    @data = { tag_list: @tag_list, no_sky_image: @no_sky_image }
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @post = current_user.posts.build
    @no_sky_image = false
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
    @post.destroy
    redirect_back fallback_location: user_root_path, notice: "削除しました。"
  end

  def show
    @post = Post.find(params[:id])
  end

  def todays_posts
    @todays_posts = Post.created_today
  end

  def this_months_posts
    @months_posts = Post.created_this_month
  end

  def tags_search
    @tag = Tag.find(params[:t_id])
    @tags_posts = @tag.posts
  end

  private

    def post_params
      params.require(:post).permit(:image, :text, :title, :image_cache, :remove_image)
    end

    def set_post
      # ユーザが投稿していないpostのアクセスを拒否する
      begin
        @post = current_user.posts.find(params[:id])
      rescue => e
        logger.error e
        flash[:alert] = "アクセスができない画面です"
        redirect_to user_root_path
      end
    end
end
