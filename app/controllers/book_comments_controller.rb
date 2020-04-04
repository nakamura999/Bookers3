class BookCommentsController < ApplicationController
	before_action :authenticate_user!

	# def create
	# 	book = Book.find(params[:book_id])
	# 	comment = current_user.book_comments.new(book_comment_params)
	# 	comment.book_id = book.id
	# 	comment.save
	# 	redirect_back(fallback_location: root_path)
	# end

	def create
      @book = Book.find(params[:book_id])
      @book_new = Book.new
      @book_comment = @book.book_comments.new(book_comment_params)
      @book_comment.user_id = current_user.id
      if @book_comment.save
        flash[:success] = "Comment was successfully created."
        redirect_to book_path(@book)
      else
        @book_comments = BookComment.where(book_id: @book.id)
        render '/books/show'
      end
    end

	# def destroy
	# 	book = Book.find(params[:book_id])
	# 	comment = current_user.book_comments.find_by(params[:id])
	# 	comment.book_id = book.id
	# 	comment.destroy
	# 	redirect_back(fallback_location: root_path)
 #    end

    def destroy
      @book_comment = BookComment.find(params[:book_id])
      if @book_comment.user != current_user
        redirect_to request.referer
      end
        @book_comment.destroy
        redirect_to request.referer
    end

    # <%= link_to "Destroy",book_book_comments_path(@book_detail.id, book_comment.id), class: "btn-sm btn-danger", method: :delete %>

    private

     def book_comment_params
      params.require(:book_comment).permit(:comment)
     end
end
