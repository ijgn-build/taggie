# == Schema Information
#
# Table name: memos
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Memo < ApplicationRecord
    has_many :tags, through: :memo_tags
    has_many :memo_tags
    accepts_nested_attributes_for :memo_tags
end
