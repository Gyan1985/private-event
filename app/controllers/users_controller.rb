class UsersController < ApplicationController
  def hosted_events
    @hosted_events = current_user.created_events.includes(:creator)
  end
end
