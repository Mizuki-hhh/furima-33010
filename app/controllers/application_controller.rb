class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, key: [:nickname, :last_name, :first_name, :furigana_last_name, :furigana_first_name, :birthday])
  end
end
