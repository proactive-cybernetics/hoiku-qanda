class AnswerReply < ApplicationRecord
  validates :answer_id, presence: true
  validates :content, presence: true, length: {maximum: 10000}
  validates :already_read, presence: true, inclusion: { in: [0, 1] }
  
  belongs_to :answer
end
