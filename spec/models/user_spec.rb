require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザ名、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      username: "text",
      email: "example@mail.com",
      password: "password"
    )

    expect(user).to be_valid
  end

  it "メールがない場合は無効な状態であること" do
    user = User.new(
      username: "text",
      email: " ",
      password: "password"
    )
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
end
