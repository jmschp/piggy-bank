class FamiliesController < ApplicationController
  def index
    @user = current_user
    @user_family = User.where(family_id: @user.family).where.not(id: @user.id)
    @family_chatroom = Chatroom.find_by(family_id: @user.family)
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
