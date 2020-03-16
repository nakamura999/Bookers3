class Book < ApplicationRecord

	belongs_to :user
	# Bookモデルに対して、Userモデルとの関係

	validates :title, presence: true
	# 本のタイトルが空欄以外
	validates :body, presence: true, length: {maximum: 200}
	# 感想200文字以内

end
