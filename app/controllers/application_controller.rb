class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
  	user_path(resource)
  end

  def after_sign_out_path_for(resource)
    flash[:notice3] = "Signed out successfully."
    home_index_path
  end

  def authentica
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    # config/intializers/device.rb書き換え
  end
end
