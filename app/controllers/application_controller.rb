class ApplicationController < ActionController::Base
  def authenticate_admin
    redirect_to root_path unless current_user.admin
  end
end
