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

  # Userモデルに対して、1:Nになるよう関連
  # class_name  一つのモデルに対して、二つのアソシエーション経路を組む場合に多用する
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

  # validationする前にaddress_1を行う
  before_validation :address_1
  def address_1
    "%s %s %s"%([self.prefecture_code, self.address_city, self.address_street])
  end
  geocoded_by :address_1
  after_validation :geocode

  has_many :following_user, through: :follower, source: :followed
  # 自分がフォローすている人
  has_many :follower_user, through: :followed, source: :follower
  # 自分をフォローしている人
  # source  class_nameとほぼ同じ
  # through 中間テーブルが複数ある場合に利用。throughオプションで中間テーブルを指定すれば、経路を決めることができる
  # 下記変更アクション名 follow,unfollow = create,destroy
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # ユーザーをフォローする
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # ユーザーのフォローを外す
  def following?(user)
    following_user.include?(user)
  end
  # フォローしていればtrueを返す


  # 下記によって、prefectureメソッドが生成され、 都道府県コード、都道府県名が参照できるようになります。
  include JpPrefecture
  jp_prefecture :prefecture_code

  # postal_codeからprefecture_nameに変換するメソッドを用意します．
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end

