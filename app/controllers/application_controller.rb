class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_family, only: [:goals_controller, :punishments_controller, :tasks_controller]
  add_flash_types :success

  private

  def set_user_family
    @user = current_user
    @user_family = User.where(family_id: @user.family).where.not(id: @user.id)
    @form_collection = @user_family.map do |family_member|
      [family_member.id, family_member.name]
    end
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, { family_attributes: [:name] }])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])

    # For additional in app/views/devise/invitations/edit.html.erb
    devise_parameter_sanitizer.permit(:invite, keys: %i[name family_id])

    # For additional in app/views/devise/invitations/edit.html.erb
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[name family_id])
  end
end
