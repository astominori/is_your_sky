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
    it "タイトル、画像、本文、タグがあれば有効な状態であること" do
      post = FactoryBot.build(:post)
      expect(post).to be_valid
    end

    it "本文がなければ無効な状態であること" do
      post = FactoryBot.build(:post, text: "")
      post.valid?
      expect(post.errors[:text]).to include("を入力してください")
    end

    it "ユーザがない場合は無効な状態であること" do
      post = FactoryBot.build(:wrong_post)
      post.valid?
      expect(post.errors[:user]).to include("を入力してください")
    end
  end

  describe "スコープテスト" do
    context ":created_today" do
      it "本日投稿されたpostを取得する" do
        post = FactoryBot.create(:post, :post_today)
        expect(Post.created_today).to include(post)
      end

      it "昨日投稿されたpostは取得しない" do
        post = FactoryBot.create(:post, :post_yesterday)
        expect(Post.created_today).not_to include(post)
      end
    end

    context ":created_this_month" do
      it "今月投稿されたpostを取得する" do
        posts = create_list(:post, 10, :post_lastweek )
        expect(Post.created_this_month).to eq(posts)
      end

      it "先月投稿されたpostは取得しない" do
        posts = create_list(:post, 10, :post_lastmonth)
        expect(Post.created_this_month).not_to eq(posts)
      end
    end

    context ":find_tags_posts" do
      before do
        user = FactoryBot.create(:user)
        @post1 = FactoryBot.create(:post, user_id: user.id)
        @post2 = FactoryBot.create(:post, user_id: user.id)
        @tag = FactoryBot.create(:tag, tag: "test1")
        @post1.save_tags(["test1"])
        @post2.save_tags(["test1"])
      end

      it "タグがついた投稿を取得できる" do
        expect(Post.find_tags_posts(@tag.id)).to include(@post1)
      end
    end
  end
end
