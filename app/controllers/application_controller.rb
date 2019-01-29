class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session
  

	def configure_permitted_parameters
    attributes = [:first_name, :last_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end
end
