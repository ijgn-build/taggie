# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
    has_many :memos, through: :memo_tags
    has_many :memo_tags
    accepts_nested_attributes_for :memo_tags
end
