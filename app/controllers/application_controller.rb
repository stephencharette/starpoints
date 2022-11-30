class ApplicationController < ActionController::Base
  def authenticate_admin
    redirect_to home_path unless current_user.present? && current_user.admin
  end
end
