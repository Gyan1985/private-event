# spec/models/event_spec.rb

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:creator).class_name('User') }
    it { should have_many(:attendances).dependent(:destroy) }
    it { should have_many(:attendees).through(:attendances).source(:attendee) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    context 'when date is in the past' do
      let(:user) { FactoryBot.create(:user) }
      let(:event) { FactoryBot.build(:event, creator: user, date: Date.today - 1) }

      it 'is invalid' do
        expect(event).not_to be_valid
      end

      it 'adds an error message' do
        event.valid?
        expect(event.errors[:date]).to include('Must be in the future')
      end
    end

    context 'when date is in the future' do
      let(:event) { FactoryBot.build(:event, date: Date.today + 1) }

      it 'is valid' do
        expect(event).to be_valid
      end
    end
  end
end
