ActiveAdmin.register Memo do
  permit_params :title, :description, memo_tags_attributes: [:memo_id, :tag_id, :name, :_destroy, :_edit]


  controller do
    def show
      @memo = Memo.find(params[:id])
      @tags = @memo.memo_tags.map { |memo_tag| memo_tag.tag.name }
      #@entity_names = @entities.map {|entity| entity.name}
      # render partial: 'show' ,locals: { entities: @entities }

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

    def create
      @memo = Memo.new(permitted_params[:memo])

      if params[:memo][:url].present?
        tag_ids_hash = []
        url_body = mechanize(params[:memo][:url])
        entities = tagging(url_body)
     
        tag_ids = Tag.import(get_tags(entities)).ids

        tag_ids.each do | tag_id |
          tag_ids_hash << Hash['tag_id', tag_id]
        end
        @memo.memo_tags.build(tag_ids_hash)
      end

      if @memo.save
        redirect_to admin_memos_path
      else
        render :action => :new
      end

    end

    # MEMO: 引数で取得したURLに大してスクレイピングしてbody要素内のテキストを返却する
    def mechanize(url)
      agent = Mechanize.new
      # page = agent.get('http://www.kayac.com/')
      # page = agent.get('https://build.ijgn.jp/')
      page = agent.get(url)
      
      page.at("body").text
    end

    # MEMO: mechanize メソッドで取得したテキストをGoogleの機械学習でエンティティに分解して返却する
    def tagging(text_content)
      language = Google::Cloud::Language.new
      response = language.analyze_entities content: text_content, type: :PLAIN_TEXT

      entities = response.entities
    end

    # MEMO: 機械学習でエンティティ化した要素をタグオブジェクトのリストとして返却する
    def get_tags(entities)
      tags = []
      entities.each do |entity|
        tags << Tag.new(name: entity.name)
      end
      tags
    end
  end

  show do
    attributes_table do
      row :title
      row :description
      row :tags do
        controller.instance_variable_get(:@tags)
      end
      # row :tags do 
      #   @memo.memo_tags.each { |memo_tag| memo_tag.tag.name }.join(', ')
      # end
    end
    # active_admin_comments　　#コメントフォーム
    # render 'some_partial'　#viewに記載したものをrenderする事も可能
  end

  form do |f|
    # エラー表示枠を表示、シンボルで項目を指定
    f.semantic_errors :name
    # モデルの入力項目を表示
    f.inputs "メモ" do
        f.input :title
        f.input :description
        f.input :url
    end
    # MEMO: タグ情報の登録・更新などのボタンの表示
    # f.inputs "タグ" do
    #   f.has_many :memo_tags, allow_destroy: true, new_record: true  do |t|
    #     t.input :tag
    #   end
    # end
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
