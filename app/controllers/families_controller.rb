class FamiliesController < ApplicationController
  def index
    user = current_user
    user_family_id = user.family_id
    @my_family = User.where(family_id: user_family_id)
  end

  def new
    @family = Family.new
  end

  def create
    @user = current_user
    @family = Family.new(family_params)

    if @family.save
      @user.admin = true
      @user.family = @family
      @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
