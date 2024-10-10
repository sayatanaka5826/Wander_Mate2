class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :post_image

  validates :title, presence: true
  validates :body, presence: true



end
