class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin_user!
    authenticate_user!
    redirect_to root_path unless current_user.admin?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit([
        :name,
        :email,
        :terms,
        :password,
        :password_confirmation,
        profile_attributes: [:phone, :city, :role]
      ])
    end
  end

end
