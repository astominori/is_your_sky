module ApplicationHelper
  def date_post(date)
    @date_post = Post.where(created_at: date)
  end
end
