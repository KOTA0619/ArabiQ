class Question < ApplicationRecord
  belongs_to :user
  
  
  validates :title, presence: true, length: { maximum: 100}
  validates :content, presence: true, length: { maximum: 1000 }
  
  has_many :answers
end
