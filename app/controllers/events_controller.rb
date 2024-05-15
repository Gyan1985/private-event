class EventsController < ApplicationController
  def index
    @events = Event.page(params[:page])
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Event not found.'
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date)
  end
end
