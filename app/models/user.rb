class User < ApplicationRecord

  attr_accessor :remember_token

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions
  def remember
    # user can log in only from single browser, subsequent logins will log user
    # out from previously logged in browser
    # self.remember_token = User.new_token
    # update_attribute(:remember_digest, User.digest(remember_token))

    # allow user to log in from multiple browsers
    if !remember_digest
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    remember_digest
  end

  def session_token
    remember_digest || remember
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
