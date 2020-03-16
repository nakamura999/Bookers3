class UsersController < ApplicationController
  before_action :authenticate_user!

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
    params.require(:user).permit(:name, :introduction, :profile_image)
    # カラムを追加
  end


end
