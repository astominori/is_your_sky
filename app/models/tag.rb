# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  tag        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  validates :tag, presence: true, uniqueness: true
  has_many :post_tag_relations, dependent: :destroy
  has_many :posts, through: :post_tag_relations
end
