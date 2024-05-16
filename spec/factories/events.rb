# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence }
    date { Faker::Date.forward(days: 30) }
    association :creator, factory: :user
  end
end
