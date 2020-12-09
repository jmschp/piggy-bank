class FamiliesController < ApplicationController
  def index
    @family_chatroom = Chatroom.find_by(family_id: @user.family)
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
