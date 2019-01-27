class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 50 }
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }
  validates :password,
    length: { minimum: 6 },
    format: { without: /\s/, message: "is not allowed with any white space" }
  validates :password_confirmation,
    presence: true
    
end
