# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  image      :string(255)
#  text       :text(65535)      not null
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
  belongs_to :user, dependent: :destroy
  #carrierWaveの設定。画像の保管
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :image, presence: true
  validates :title, presence: true
  default_scope -> { order(created_at: :desc) }
end
