class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @user_posts = current_user.posts.all.order(created_at: "DESC")
    all_posts = Post.all
    @posts_by_date = all_posts.group_by{|post| post.updated_at.to_date}
  end

  private
  def delete_cache
    CarrierWave.clean_cached_files!
  end
end
