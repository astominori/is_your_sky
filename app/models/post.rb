# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  image      :string(255)
#  text       :string(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :text, presence: true, length: { minimum: 5 }
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations
  scope :created_today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
  scope :created_this_month, -> { where("created_at >= ?", Time.zone.now.beginning_of_month) }
  scope :find_tags_posts, -> (id) { joins(:tags).where( tags: { id: id }) }

  def save_tags(tags)
    current_tags = self.tags.pluck(:tag) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    #古いタグを削除する
    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(tag: old_tag)
    end

    #新しいタグをつける
    new_tags.each do |new_tag|
      post_tag = Tag.find_or_create_by(tag: new_tag)
      self.tags << post_tag
    end
  end
end
