module ApplicationHelper
  def date_posts(date)
    @date_posts = Post.where(created_at: date)
  end
end
