class User < ApplicationRecord

  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
    self.update_attribute(:remember_digest, User.digest(self.remember_token))
    self.remember_token
  end

  def authenticate_remember_token(token)
    return false if self.remember_digest ==  nil
    BCrypt::Password.new(self.remember_digest) == token
  end

  def forget
    self.update_attribute(:remember_digest, nil)
  end

end