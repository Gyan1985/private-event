# frozen_string_literal: true

# Create Users

event_host = User.find_or_create_by!(
  email: 'event_host@example.com'
) do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end

puts "Event host created: #{event_host.email}"

event_attendee = User.find_or_create_by!(
  email: 'event_attendee@example.com'
) do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end

puts "Event attendee created: #{event_attendee.email}"

# Create Events
future_event = Event.find_or_create_by(name: 'Event 1', date: Date.today + 1.day, creator: event_host)

puts "Event for future created: #{future_event.name}"

past_event = Event.find_or_initialize_by(name: 'Event 2', date: Date.today - 1.day, creator: event_host)
past_event.save(validate: false)

puts "Event for past created: #{past_event.name}"

attendee_hosted_event = Event.find_or_create_by(name: 'Event 3', date: Date.today + 1.day, creator: event_attendee)

puts "Event hosted by attendee created: #{attendee_hosted_event.name}"

# Create some attendances
Attendance.find_or_create_by(attendee: event_attendee, event: future_event)
Attendance.find_or_create_by(attendee: event_attendee, event: past_event)
