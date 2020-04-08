class UsersController < ApplicationController
  before_action :authenticate_user!
  # ↑ログインしているユーザーがuserにアクセスできる

  # ローカル変数→使用できる範囲が限られている。メソッドやブロック内で定義した場合、そのメソットやブロック内で使用可能となる。
  # インスタンス変数（@)→同じオブジェクト内（同クラス内）で共有可能な変数

  def show
  	@user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @books = Book.all
  end

  def index
    @users = User.all
    @book =Book.new
    @books = Book.all
    @user = current_user
  end

  def edit
  	@user = User.find(params[:id])
   if @user.id != current_user.id
      redirect_to user_path(current_user.id)
   end
  end

  def follows
    @user = User.find(params[:id])
    @users = User.all
  end

  def followers
    @user = User.find(params[:id])
    @users = User.all
  end


  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
  	   redirect_to user_path(@user.id)
    else
       flash[:notice] = "1 error prohibited this obj from being saved:Introduction is too long (maximum is 50 characters)"
       # redirect_to edit_user_path(@user.id)
       redirect_to user_path(@user.id)
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_code,:address_city, :address_street, :latitude, :longitude)
  end
    # カラムを追加
    # コントローラー作成(アクション付き) g controller モデル名s アクション名(複数あり）
    # モデルにカラム追加　ターミナル { g migrate Addカラム(先頭大文字)名Toモデル名(テーブル名)s カラム名:データ型 }  → 後 rails db:migrate
    # /db/migrate/schema.rbにカラム項目
    # redirect_to アクション内の定義も持っていく
    # render そのままviewへいく
    # find 主キーに対応するレコードを取り出す
    # find_by 与えられた条件にマッチするレコードのうち、最初のレコードだけ返す


end
