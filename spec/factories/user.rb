FactoryBot.define do
  factory :user do
    username { "test" }
    email { "example@mail.com" }
    password { "password" }
  end
end
