class ChatsController < ApplicationController
	before_action :authenticate_user!, :only => [:create]

	def create
		if UserRoom.where(:user_id => current_user.id, :room_id => params[:chat][:room_id]).present?
			@chat = Chat.create(params.require(:chat).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
		else
			redirect_back(fallback_location: root_path)
		end
	end

 # <%= form_for @chat do |f| %>
 #      <%= f.text_field :content, :placeholder => "メッセージを入力して下さい" , :size => 70 %>
 #      <%= f.hidden_field :room_id, :value => @room.id %>
 #      <br>
 #      <%= f.submit "投稿する", class: "btn btn-primary" %>
 #    <% end %>
end
