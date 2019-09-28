class Memo < ApplicationRecord
  has_many :tags, through: :memo_tags
  has_many :memo_tags
end
