FactoryBot.define do
  factory :user do
    username { "test" }
    sequence(:email) { |n| "example-#{n}@mail.com" }
    password { "password" }
    confirmed_at { Date.today }

    trait :other_user do
      username { "other_user" }
      email { "example_other@mail.com" }
    end
  end
end
