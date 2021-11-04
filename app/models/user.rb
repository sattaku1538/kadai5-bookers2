class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # ↓↓フォロー機能
  has_many :relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :relationships, source: :followed
  # フォローする側からのhas_manyの記述。13行目は自由に定義できる。
  
  
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
  has_many :followeds, through: :reverse_of_relationships, source: :follower
  # フォローされる側からのhas_manyの記述
  
  def follower_by?(user)
    reverse_of_relationships.where(follower_id: user.id).present?
  end
  
  # def followed_by?(user)
  #   relationships.where(followed_id: user.id).exists?
  # end  
  
  # def is_followed_by?(user)
  #   reverse_of_relationships.find_by(following_id: user.id).present?
  # end
  
  # ↓↓DMMカリキュラムの参考例
  # # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  # has_many :xxx, class_name: "モデル名", foreign_key: "○○_id", dependent: :destroy
  # # @user.booksのように、@user.yyyで、
  # # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  # has_many :yyy, through: :xxx, source: :zzz
  
  
  attachment :profile_image

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 } 
  
  
  # ↓Uniquness1ユーザーが1ツイートが投稿できる。
  # validates_uniqueness_of :book_id, scope: :user_id
  # def already_favorited?(book)
  #   self.favorites.exists?(book_id: book.id)
  # end
end
