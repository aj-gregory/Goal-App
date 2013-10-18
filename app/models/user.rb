class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password

  before_validation :ensure_validation_token
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, :on => :create
  validates :password_digest, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true

  has_many :goals
  has_many :given_cheers, :class_name => "Cheer"

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(username, pass)
    user = User.find_by_username(username)
  end
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  def password=(pass)
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end

  def is_password?(pass)
    password_matcher = BCrypt::Password.new(self.password_digest)
    password_matcher.is_password?(pass)
  end

  private

  def ensure_validation_token
    self.session_token ||= self.class.generate_session_token
  end
end
