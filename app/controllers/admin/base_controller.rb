class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :ensure_admin!
  before_action :check_user_timeout

  private

  def ensure_admin!
    redirect_to root_path, alert: "Access denied. Admin privileges required." unless current_user&.admin?
  end

  def check_user_timeout
    return unless current_user

    timeout_period = 30.minutes # 30 minutes session timeout
    last_activity = current_user.current_sign_in_at || current_user.created_at

    if last_activity && last_activity < timeout_period.ago
      Rails.logger.info "Admin user #{current_user.email} timed out. Last activity: #{last_activity}"
      sign_out current_user
      redirect_to new_user_session_path, alert: "Your session has expired due to inactivity. Please sign in again."
      return
    end

    # Update last activity timestamp
    current_user.update_column(:current_sign_in_at, Time.current)
  end
end
