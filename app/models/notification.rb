class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
  belongs_to :question, optional: true
  belongs_to :answer, optional: true
end
