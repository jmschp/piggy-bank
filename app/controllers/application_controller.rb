class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])

    # For additional in app/views/devise/invitations/edit.html.erb
    devise_parameter_sanitizer.permit(:invite, keys: [:name])

    # For additional in app/views/devise/invitations/edit.html.erb
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end
end
