class Domain
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :url, type: String
  field :_id, type: String, default: ->{ name.to_s.parameterize }

  validates_presence_of :name
  embeds_many :events
  belongs_to :user
end
