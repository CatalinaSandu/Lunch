class User < ActiveRecord::Base
  # Include default devise modules.
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  before_save :ensure_authentication_token
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
    self.role ||= :user
  end

  def set_role
    self.role ||= :admin
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_access_token
    end
  end

  private

  def generate_access_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
