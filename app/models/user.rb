class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: VALID_EMAIL_REGEX
  
  has_secure_password
  validates :password, presence: true, length: { in: 8..32 }, format: { with: /\A[A-Za-z\d]{8,32}\z/i }
  
  has_many :question
  has_many :answer
end
