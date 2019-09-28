class CreateMemoTags < ActiveRecord::Migration[5.2]
  def change
    create_table :memo_tags do |t|
      t.references :memo, foreign_key: true, foreign_key: { on_delete: :cascade }
      t.references :tag, foreign_key: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
