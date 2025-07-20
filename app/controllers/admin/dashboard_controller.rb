class Admin::DashboardController < Admin::BaseController
  def index
    @properties_count = Property.count
    @recent_properties = Property.order(created_at: :desc).limit(5)
    @users_count = User.count
    @admin_users_count = User.where(admin: true).count
  end
end