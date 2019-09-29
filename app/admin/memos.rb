ActiveAdmin.register Memo do
  permit_params :title, :description, memo_tags_attributes: [:memo_id, :tag_id, :name, :_destroy, :_edit]

  form do |f|
    # エラー表示枠を表示、シンボルで項目を指定
    f.semantic_errors :name
    # モデルの入力項目を表示
    f.inputs "メモ" do
        f.input :title
        f.input :description
    end
    # 登録・更新などのボタンの表示
    f.inputs "タグ" do
      f.has_many :memo_tags, allow_destroy: true, new_record: true  do |t|
        t.input :tag
      end
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
