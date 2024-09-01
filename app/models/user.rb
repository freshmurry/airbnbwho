class User < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "guest.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
        :omniauthable
  
  validates :fullname, presence: true, length: {maximum: 50}
  
  has_attached_file :image  
  has_many :rooms
  has_many :reservations
  has_many :guest_reviews, class_name: "GuestReview", foreign_key: "guest_id"
  has_many :host_reviews, class_name: "HostReview", foreign_key: "host_id"
  has_many :notifications
  has_one :setting

  after_create :add_setting

  def add_setting
    Setting.create(user: self, enable_sms: true, enable_email: true)
  end
    
  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)

    if user
      user
    else
      create(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        fullname: auth.info.name,
        image: auth.info.image
      ).tap { |user| user.skip_confirmation! }
    end
  end

  def generate_pin
    self.pin = SecureRandom.hex(2)
    self.phone_verified = false
    save
  end
  
  def send_pin
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+12568264730',
      to: self.phone_number,
      body: "Your AirbnbWho pin is #{self.pin}"
    )
  end

  def verify_pin(entered_pin)
    update(phone_verified: true) if self.pin == entered_pin
  end

  def is_active_host
    !self.merchant_id.blank?
  end

end

# Strict password security measures. *Uncomment when app goes live!*
  # validates :password, :presence => true,
  #                   :on => :create,
  #                   :format => {:with => /\A.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\!\@\#\$\%\^\&\+\=]).*\Z/ }