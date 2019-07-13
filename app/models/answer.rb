class Answer < ApplicationRecord
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
  validates :already_read, presence: true, inclusion: { in: [0, 1] }
  
  belongs_to :question
  belongs_to :user
  has_one :answer_reply
end
