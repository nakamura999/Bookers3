class FavoritesController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.new(book_id: book.id)
		favorite.save
        redirect_back(fallback_location: root_path)
        # 直前のページへリダイレクトする
	end

    # 解答
	# def create
 #      @book = Book.find(params[:book_id])
 #      favorite = @book.favorites.new(user_id: current_user.id)
 #      favorite.save
 #      redirect_to request.referer
 #  　end

	def destroy
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
        redirect_back(fallback_location: root_path)
	end

    # def destroy
    #   @book = Book.find(params[:book_id])
    #   favorite = current_user.favorites.find_by(book_id: @book.id)
    #   favorite.destroy
    #   redirect_to request.referer
    # end

    # private
    # def redirect
    #   case params[:redirect_id].to_i
    #   when 0
    #     redirect_to books_path
    #   when 1
    #     redirect_to book_path(@book)
    #   end
    # end

    # showページ　いいね機能解答 redirect_id: 1
        # <td>
        #   <% if @book.favorited_by?(current_user) %>
        #     <%= link_to book_favorites_path(@book, redirect_id: 0), method: :delete do %>
        #       <span class="glyphicon glyphicon-heart"><%= @book.favorites.count%></span>
        #     <% end %>
        #   <% else %>
        #     <%= link_to book_favorites_path(@book, redirect_id: 0), method: :post do %>
        #       <span class="glyphicon glyphicon-heart-empty"><%= @book.favorites.count %></span>
        #     <% end %>
        #   <% end %>
        # </td>

    # indexページ　いいね機能解答
    # <td>
    #   <% if book.favorited_by?(current_user) %>
    #      <%= link_to book_favorites_path(book, redirect_id: 0), method: :delete do %>
    #        <%#= fa_icon "heart", text: "#{book.favorites.count}", style: "color: red;" %>
    #        <span class="glyphicon glyphicon-heart"><%= book.favorites.count%></span>
    #      <% end %>
    #   <% else %>
    #      <%= link_to book_favorites_path(book, redirect_id: 0), method: :post do %>
    #        <%#= fa_icon "heart-o", text: "#{book.favorites.count}", style: "color: red;" %>
    #        <span class="glyphicon glyphicon-heart-empty"><%= book.favorites.count %></span>
    #      <% end %>
    #   <% end %>
    # </td>
end
