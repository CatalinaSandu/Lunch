class User < ActiveRecord::Base
  # Include default devise modules.
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?


  before_save :ensure_authentication_token
  before_save :set_expiration

  devise :database_authenticatable, :async, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def set_default_role
    self.role ||= :user
  end

  def set_role
    self.role ||= :admin
  end

  def expired?
    Time.zone.now >= self.expires_at
  end

  def ensure_authentication_token
    if authentication_token.blank? || expired?
      self.authentication_token = generate_access_token
    end
  end

  private

  def generate_access_token
    loop do
      token = Devise.friendly_token
      set_expiration
      break token unless User.where(authentication_token: token).first

    end
  end

  def set_expiration
    self.expires_at = Time.zone.now+1.day
  end
end
