class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,         type: Integer, default: 0
  field :current_sign_in_at,    type: Time
  field :last_sign_in_at,       type: Time
  field :current_sign_in_ip,    type: String
  field :last_sign_in_ip,       type: String
  field :authentication_token,  type: String

  before_create :generate_authentication_token

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  has_many :domains

  def domain_from_caller(referer)
    uri = URI.parse(referer)
    request_origin = "#{uri.scheme}://#{uri.host}"

    if uri.port != 80
      request_origin += ":#{uri.port}"
    end
    self.domains.where(url: request_origin).first
  end

  private

  def generate_authentication_token
    self.authentication_token = SecureRandom.hex(32)
  end
end








