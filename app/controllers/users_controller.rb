class UsersController < ApplicationController
  def hosted_events
    hosted_events = current_user.created_events.includes(:creator)
    @hosted_events = hosted_events.page(params[:page])
  end
end
