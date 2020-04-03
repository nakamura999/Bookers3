class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # :database_authenticatable（パスワードの正確性を検証）
  # :registerable（ユーザ登録や編集、削除）
  # :recoverable（パスワードをリセット）
  # :rememberable（ログイン情報を保存）
  # :validatable（emailのフォーマットなどのバリデーション）
  validates :name, presence: true, length: 2..20
  # user名前２から20文字いない
  validates :introduction, length: {maximum: 50}
  # プロフィール文50文字いない
  attachment :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  # Userモデルに対して、Bookモデルが1:Nになるよう関連

end
