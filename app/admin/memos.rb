require 'mechanize'
ActiveAdmin.register Memo do
  permit_params :title, :description, memo_tags_attributes: [:memo_id, :tag_id, :name, :_destroy, :_edit]

  controller do
    layout 'active_admin'
    def show
      @mechanize = mechanize
      render partial: 'show', locals: {page_content: @mechanize}
      
      #post_params = permitted_params[:user]
      #@user = User.new(post_params)
      ## 何らかのカスタム処理
      #if @user.save
      #  # 保存に成功したら一覧画面にリダイレクト
      #  redirect_to collection_path
      #else
      #  # 保存に失敗したらformテンプレート出力
      #  # validationエラーが表示される
      #  # layout: active_adminがないとヘッダ・フッタが出力されないので注意
      #  render "_form", layout: "active_admin"
      #end
    end
    def mechanize
      agent = Mechanize.new
      # page = agent.get('http://www.kayac.com/')
      page = agent.get('https://build.ijgn.jp/')
      
      page.at("body").text
    end
  end

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
