class FamiliesController < ApplicationController
  def index
    @user = current_user
    @user_family = User.where(family_id: @user.family) - [@user]
    
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
