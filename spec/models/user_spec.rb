require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "ユーザ名、メール、パスワードがあれば有効な状態であること" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "メールがない場合は無効な状態であること" do
      user = FactoryBot.build(:user,
        email: ""
      )
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "パスワードが6文字未満であれば無効な状態であること" do
      user = FactoryBot.build(:user,
        password: "aaaaa"
      )
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "パスワードが6文字であれば有効な状態であること" do
      user = FactoryBot.build(:user,
        password: "aaaaaa"
      )
      expect(user).to be_valid
    end
  end
end
