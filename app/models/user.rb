class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :entries, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :entries

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :bio, length: { maximum: 200 }

  enum gender: {male: 0 , female: 1, other: 2}
  enum age: {teens: 0 , twenties: 1, thirties: 2, forties: 3, fifties: 4,
    sixties: 5, seventies: 6, older: 7}
  enum smoking: {smoker: 0 , non_smoker: 1}
  enum drinking: {drinker: 0 , non_drinker: 1}
  enum favorite_area: {north_america: 0 , south_america: 1, europe: 2, africa: 3,
    asia: 4, oceania: 5, others: 6}
  enum budget: {low: 0 , normal: 1, high: 2}


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
