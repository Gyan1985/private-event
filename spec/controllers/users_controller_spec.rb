require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'GET #hosted_events' do
    it 'assigns @hosted_events with paginated created events of current user' do
      hosted_events = create_list(:event, 5, creator: user)
      get :hosted_events
      expect(controller.instance_variable_get(:@hosted_events).count).to eq(hosted_events.count)
    end
  end

  describe 'GET #attendent_events' do
    it 'assigns @past_events and @upcoming_events with paginated events attended by current user' do
      past_event = build(:event, date: 1.day.ago)
      past_event.save(validate: false)

      upcoming_event = create(:event, date: 1.day.from_now)

      user.attendances.create(event: past_event)
      user.attendances.create(event: upcoming_event)

      get :attendent_events
      expect(controller.instance_variable_get(:@past_events).count).to eq(1)
      expect(controller.instance_variable_get(:@upcoming_events).count).to eq(1)
    end
  end
end
