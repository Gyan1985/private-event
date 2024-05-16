require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event, creator: user) }

  before do
    sign_in user
  end
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #new' do
    it 'assigns a new event' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #new' do
    it 'render a show template when event exist' do
      get :show, params: { id: event.id }
      expect(response.status).to eq(200)
    end

    it 'render a show template when event exist' do
      get :show, params: { id: 999 }
      expect(flash[:alert]).to eq('Event not found.')
      expect(response).to redirect_to(events_path)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new event' do
        expect do
          post :create, params: { event: attributes_for(:event) }
        end.to change(Event, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a new event' do
        expect do
          post :create, params: { event: { name: nil } }
        end.to_not change(Event, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the event' do
        put :update, params: { id: event.id, event: { name: 'New Event Name' } }
        event.reload
        expect(event.name).to eq('New Event Name')
      end
    end

    context 'with invalid params' do
      it 'does not update the event' do
        put :update, params: { id: event.id, event: { name: nil } }
        event.reload
        expect(event.name).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the event' do
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST #join' do
    it 'allows user to join the event' do
      post :join, params: { id: event.id }
      expect(response).to redirect_to(event_path(event))
      expect(flash[:notice]).to eq('You have successfully joined the event.')
    end
  end

  describe 'POST #leave' do
    it 'allows user to leave the event' do
      user.attendances.create(event: event)

      post :leave, params: { id: event.id }
      expect(response).to redirect_to(event_path(event))
      expect(flash[:notice]).to eq('You have successfully left the event.')
    end
  end
end
