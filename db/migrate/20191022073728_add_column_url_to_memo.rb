class AddColumnUrlToMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :url, :string 
  end
end
