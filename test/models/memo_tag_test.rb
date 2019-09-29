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

require 'test_helper'

class MemoTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
