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
