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
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーションテスト" do
    it "タイトル、画像、本文があれば有効な状態であること" do
      post = FactoryBot.build(:post)
      expect(post).to be_valid
    end

    it "本文がなければ無効な状態であること" do
      post = FactoryBot.build(:post,
        text: ""
      )
      post.valid?
      expect(post.errors[:text]).to include("を入力してください")
    end

    it "ユーザがない場合は無効な状態であること" do
      post = FactoryBot.build(:wrong_post)
      post.valid?
      expect(post.errors[:user]).to include("を入力してください")
    end
  end
end
