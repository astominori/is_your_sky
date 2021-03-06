class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_posts = current_user.posts.all.order(created_at: "DESC")
    all_posts = Post.where.not(user_id: current_user.id).order(created_at: "DESC")
    @posts_by_date = all_posts.group_by { |post| post.created_at.to_date }
  end
end
