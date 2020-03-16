class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @book =Book.new
    @books = Book.all
    @user = current_user
  end

  def show
  	@book_detail = Book.find(params[:id])
  	@book = Book.new
  	@books = Book.all
    @user = @book_detail.user
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	# current_user サインインしているユーザー
  	if @book.save
  	flash[:notice2] = "Book was successfully created."
  	redirect_to book_path(@book.id)
    else
    @books = Book.all
    @user = current_user
    render action: :index
   end
  end

  def update
  	book = Book.find(params[:id])
  	if book.update(book_params)
  	 flash[:notice] = "Book was successfully updated."
  	 redirect_to book_path(book.id)
  	else
  	 flash[:notice] = "error"
  	 @book = Book.find(params[:id])
     render action: :edit
    end
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
   end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	flash[:notice] = "Book was successfully destroyed."
  	redirect_to books_path
  end

  # index リソースの一覧表示
  # new リソースを新規作成
  # create リソースを新規作成して追加
  # edit リソースを更新するためのフォーム
  # show レコードの内容を表示する
  # update リソースを更新する
  # destroy リソースを削除する

  private

  def book_params
     params.require(:book).permit(:title, :body, :user_id)
  end

end
