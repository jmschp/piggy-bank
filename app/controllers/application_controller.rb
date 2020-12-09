class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success
  before_action :set_user_family, only: %i[index new create], if: :selected_controller?

  def default_url_options
  { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def selected_controller?
    controller_name.match(/(families|tasks|goals|punishments)/)
  end

  def set_user_family
    @user = current_user
    @user_family = User.where(family_id: @user.family).where.not(id: @user.id)
    @form_collection = @user_family.pluck(:id, :name)
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, { family_attributes: [:name] }])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])

    # For additional in app/views/devise/invitations/new.html.erb
    devise_parameter_sanitizer.permit(:invite, keys: %i[name family_id])

    # For additional in app/views/devise/invitations/edit.html.erb
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[name family_id])
  end
end
