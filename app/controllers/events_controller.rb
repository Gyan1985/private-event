class EventsController < ApplicationController
  before_action :set_event, only: %i[show join leave]
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

  def join
    event_attendance = @event.attendances.new(attendee: current_user)
    if event_attendance.save!
      redirect_to @event, notice: 'You have successfully joined the event.'
    else
      redirect_to @event, status: :unprocessable_entity
    end
  end

  def leave
    attendance = current_user.attendances.find_by(event: @event)
    return unless attendance.destroy

    redirect_to @event, notice: 'You have successfully left the event.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Event not found.'
    redirect_to events_path
  end

  def event_params
    params.require(:event).permit(:name, :date)
  end
end
