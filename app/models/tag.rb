class Tag < ApplicationRecord
    has_many :memos, through: :memo_tags
    has_many :memo_tags
    accepts_nested_attributes_for :memo_tags
end
