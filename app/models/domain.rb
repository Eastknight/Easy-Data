class Domain
  require 'uri'
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :url, type: String
  # field :_id, type: String, default: ->{ name.to_s.parameterize }
  field :verification_token, type: String
  field :verified, type: Boolean, default: false

  validates_presence_of :name, :url
  embeds_many :events
  belongs_to :user, index: true

  before_create :generate_verification_token
  before_validation :normalize_url

  private

  def normalize_url
    if self.url
      uri = URI.parse(self.url)
      if !uri.host
        self.url = "http://" + self.url
      end
    end
  end


  def generate_verification_token
    self.verification_token = SecureRandom.hex(30)
  end
end
