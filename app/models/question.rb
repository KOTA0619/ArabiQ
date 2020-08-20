class Question < ApplicationRecord
  belongs_to :user
  
  
  validates :title, presence: true, length: { maximum: 100}
  validates :content, presence: true, length: { maximum: 1000 }
  
  has_many :answers, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  def save_notification_answer(current_user, question_id, answer_id, visited_id)
    notification = current_user.active_notifications.new(
      question_id: question_id,
      answer_id: answer_id,
      visited_id: visited_id,
      action: 'answer'
      )
      
    notification.save
  end
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites, dependent: :destroy
  
  def liked_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
