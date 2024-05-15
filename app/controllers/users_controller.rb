class UsersController < ApplicationController
  def hosted_events
    hosted_events = current_user.created_events.includes(:creator)
    @hosted_events = hosted_events.page(params[:page])
  end

  def attendent_events
    attendent_events = Event.joins(:attendances).where(attendances: { attendee: current_user })
    @past_events = attendent_events.past.order(date: :desc).page(params[:page])
    @upcoming_events = attendent_events.future.order(date: :asc).page(params[:page])
  end
end
