# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:created_events).class_name('Event').with_foreign_key('creator_id') }
    it { should have_many(:attendances).with_foreign_key('attendee_id').dependent(:destroy) }
    it { should have_many(:attended_events).through(:attendances).source(:event) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(128) }
  end

  describe 'methods' do
    let(:user) { FactoryBot.create(:user) }

    it 'creates a user with valid attributes' do
      expect(user).to be_valid
    end

    it 'creates an event associated with the user' do
      event = FactoryBot.create(:event, creator: user)
      expect(user.created_events).to include(event)
    end

    it 'attends an event' do
      event = FactoryBot.create(:event)
      user.attended_events << event
      expect(user.attended_events).to include(event)
    end
  end
end
