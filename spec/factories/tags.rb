# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  tag        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_tag  (tag) UNIQUE
#
FactoryBot.define do
  factory :tag do
    tag { "MyString" }
  end
end
