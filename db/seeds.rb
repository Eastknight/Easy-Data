require 'faker'

3.times do 
  Domain.create!(
    name: Faker::App.name,
    url: Faker::Internet.url,
    user: User.first 
  )
end

domains = Domain.all

30.times do 
  event = domains.sample.events.create!(
    name: Faker::Hacker.verb
  )
  event.update_attribute :created_at, (rand*10).days.ago
end
