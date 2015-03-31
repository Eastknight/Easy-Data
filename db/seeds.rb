require 'faker'

domain = Domain.new(
  name: "Example",
  url: "http://www.example.com",
  user: User.first 
)
domain.save
domain.update_attributes(verified: true)

events1 = ["Sign in", "Sign up"]
events2 = ["Upload pictures", "Edit user info"]


5000.times do 
  event = domain.events.create!(
    name: "Sign in"
  )
  event.update_attribute :created_on, (rand*35).days.ago
end

2000.times do 
  event = domain.events.create!(
    name: "Sign up"
  )
  event.update_attribute :created_on, (rand*35).days.ago
end

300.times do 
  event = domain.events.create!(
    name: "Upload pictures"
  )
  event.update_attribute :created_on, (rand*35).days.ago
end

200.times do 
  event = domain.events.create!(
    name: "Edit user info"
  )
  event.update_attribute :created_on, (rand*35).days.ago
end

500.times do 
  event = domain.events.create!(
    name: "Send post"
  )
  event.update_attribute :created_on, (rand*35).days.ago
end

4750.times do 
  event = domain.events.create!(
    name: "Write comments"
  )
  event.update_attribute :created_on, (rand*35).days.ago
end