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

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :bio, length: { maximum: 150 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image2.png')
      profile_image.attach(io: File.open(file_path), filename: 'no_image2.png', content_type: 'image/png')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  enum gender: {male: 0 , female: 1, other: 2}
  enum age: {teens: 0 , twenties: 1, thirties: 2, forties: 3, fifties: 4,
    sixties: 5, seventies: 6, older: 7}
  enum smoking: {smoker: 0 , non_smoker: 1}
  enum drinking: {drinker: 0 , non_drinker: 1}
  enum favorite_area: {north_america: 0 , south_america: 1, europe: 2, africa: 3,
    asia: 4, oceania: 5, others: 6}
  enum budget: {low: 0 , normal: 1, high: 2}

  def gender_japanese
    case gender
    when "male"
      "男性"
    when "female"
      "女性"
    when "other"
      "その他"
    else
      "非公開"
    end
  end

  def age_japanese
    case age
    when "teens"
      "10代"
    when "twenties"
      "20代"
    when "thirties"
      "30代"
    when "forties"
      "40代"
    when "fifties"
      "50代"
    when "sixties"
      "60代"
    when "seventies"
      "70代"
    when "older"
      "それ以上"
    else
      "非公開"
    end
  end

  def smoking_japanese
    case smoking
    when "smoker"
      "吸う"
    when "non_smoker"
      "吸わない"
    else
      "非公開"
    end
  end

  def drinking_japanese
    case drinking
    when "drinker"
      "飲む"
    when "non_drinker"
      "飲まない"
    else
      "非公開"
    end
  end

  def favorite_area_japanese
    case favorite_area
    when "north_america"
      "北アメリカ"
    when "south_america"
      "南アメリカ"
    when "europe"
      "ヨーロッパ"
    when "africa"
      "アフリカ"
    when "asia"
      "アジア"
    when "oceania"
      "オセアニア"
    when "others"
      "その他"
    else
      "非公開"
    end
  end

  def budget_japanese
    case budget
    when "low"
      "￥"
    when "normal"
      "￥￥"
    when "high"
      "￥￥￥"
    else
      "非公開"
    end
  end


end
