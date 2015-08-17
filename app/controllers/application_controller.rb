class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?

  def after_sign_in_path_for(users)
    lihp_url
  end

  def after_sign_out_path_for(users)
    root_url
  end

  protected
  def configure_permitted_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:fname, :lname, :profession, :city, :state, :country, :email, :password, :password_confirmation, :tutor, :student, :team)
    end
  end

end
