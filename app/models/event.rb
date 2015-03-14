class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :data, type: Hash

  embedded_in :domain
end
