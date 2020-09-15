# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  avatar          :string(255)
#  bio             :string(255)
#  email           :string(255)      not null
#  name            :string(255)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  #carrierWaveの設定。画像の保管
  mount_uploader :avatar, AvatarUploader
  has_secure_password
  has_many :posts, foreign_key: :user_id, dependent: :destroy
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
    length: {maximum: 16}
  validates :email, presence: true,
    format: {
      with: VALID_EMAIL_REGEX,
      message: "は正しいメールアドレスを入力してください"
    }

  #passwordが空欄であっても変更を通す
  validates :password, length: { minimum: 8 }, allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
