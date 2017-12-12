class UsersController < ApplicationController
  before_action :set_last_seen_at, if: proc { user_signed_in? && (user.last_seen_at.nil? || user.last_seen_at < 15.minutes.ago) }

  private
  def set_last_seen_at
    current_user.update_column(:last_seen_at, Time.now)
  end
  
end
