# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Clear existing data

Flight.destroy_all
Airport.destroy_all

# Create airports
airports = [
  { code: 'SFO', name: 'San Francisco International' },
  { code: 'NYC', name: 'New York City' },
  { code: 'LAX', name: 'Los Angeles International' },
  { code: 'ORD', name: "Chicago O'Hare" },
  { code: 'MIA', name: 'Miami International' }
]

airports.each do |airport_data|
  Airport.create!(airport_data)
end

# Create flights
def create_flight(departure_code, arrival_code, start_time, duration)
  departure = Airport.find_by(code: departure_code)
  arrival = Airport.find_by(code: arrival_code)

  Flight.create!(
    departure_airport: departure,
    arrival_airport: arrival,
    start_date: start_time,
    duration: duration
  )
end

# Create flights for the next 7 days
today = Date.today
(0..6).each do |day_offset|
  date = today + day_offset.days

  # SFO to NYC
  create_flight('SFO', 'NYC', date + 8.hours, 330) # 5:30 AM departure
  create_flight('SFO', 'NYC', date + 14.hours, 330) # 11:30 AM departure

  # NYC to SFO
  create_flight('NYC', 'SFO', date + 10.hours, 330) # 7:30 AM departure
  create_flight('NYC', 'SFO', date + 16.hours, 330) # 1:30 PM departure

  # LAX to ORD
  create_flight('LAX', 'ORD', date + 9.hours, 240) # 6:00 AM departure
  create_flight('LAX', 'ORD', date + 15.hours, 240) # 12:00 PM departure

  # ORD to LAX
  create_flight('ORD', 'LAX', date + 11.hours, 240) # 8:00 AM departure
  create_flight('ORD', 'LAX', date + 17.hours, 240) # 2:00 PM departure

  # MIA to NYC
  create_flight('MIA', 'NYC', date + 8.hours, 180) # 5:00 AM departure
  create_flight('MIA', 'NYC', date + 14.hours, 180) # 11:00 AM departure

  # NYC to MIA
  create_flight('NYC', 'MIA', date + 10.hours, 180) # 7:00 AM departure
  create_flight('NYC', 'MIA', date + 16.hours, 180) # 1:00 PM departure
end

puts "Created #{Airport.count} airports and #{Flight.count} flights"
