class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :created_on, type: Date

  embedded_in :domain

  before_create :set_date

  private

  def set_date
    self.created_on = Date.today
  end 
end
