class Room < ApplicationRecord
  
  has_many :chats, dependent: :destroy
  has_many :enrtries, dependent: :destroy
  
end
