class Question < ApplicationRecord
  
  # 質問の状態 : 
  DRAFT = 0
  CALLING_ANSWERS = 1
  FINALIZED = 2
  
  validates :title, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 10000 }
  validates :status, inclusion: {in: [DRAFT, CALLING_ANSWERS, FINALIZED] }

  belongs_to :user
  has_many :answers
  has_many :answer_users, through: :answers, source: 'user'
  has_many :answer_answer_replies, through: :answers, source: 'answer_reply'
end
