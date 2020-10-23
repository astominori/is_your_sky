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
require 'rails_helper'

RSpec.describe Tag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
