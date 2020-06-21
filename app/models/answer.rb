class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  validates :content, presence: true, length: { maximum: 1000 }
  
  has_many :notifications, dependent: :destroy
  
  mount_uploader :image, ImageUploader
end
