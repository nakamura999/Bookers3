class Book < ApplicationRecord

	belongs_to :user
	# Bookモデルに対して、Userモデルとの関係
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
       favorites.where(user_id: user.id).exists?
    end

	validates :title, presence: true
	# 本のタイトルが空欄以外
	validates :body, presence: true, length: {maximum: 200}
	# 感想200文字以内

end
