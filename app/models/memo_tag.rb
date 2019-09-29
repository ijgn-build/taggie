# == Schema Information
#
# Table name: memo_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  memo_id    :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_memo_tags_on_memo_id  (memo_id)
#  index_memo_tags_on_tag_id   (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (memo_id => memos.id) ON DELETE => cascade
#  fk_rails_...  (tag_id => tags.id) ON DELETE => cascade
#

class MemoTag < ApplicationRecord
  belongs_to :memo
  belongs_to :tag
end
