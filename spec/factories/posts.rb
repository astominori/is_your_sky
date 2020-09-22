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
FactoryBot.define do
  factory :post do
    title { "test" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test-sample.jpg'))  }
    text { "text-test" }
    association :user
  end

  factory :wrong_post, class: Post do
    title { "test" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test-sample.jpg'))  }
    text { "text-test" }
  end
end
