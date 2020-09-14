FactoryBot.define do
  factory :post do
    title { "タイトル1" }
    text { "テキスト1" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.jpg')) }
  end
end
