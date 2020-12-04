class PunishmentsController < ApplicationController
  before_action :set_user_family, only: %i[index create]

  def index
    @selected_son = params[:user_son]
    @punishment = Punishment.new
    if @selected_son.present?
      @son = User.find(@selected_son)
      @son_punishments = Punishment.where(user_id: @selected_son)
    end
  end

  def create
    @punishment = Punishment.new(punishment_params)
    @punishment.user = current_user
    user_ids = params[:punishment][:user_id]

    if @punishment.valid? && user_ids.count >= 2
      user_ids.each do |user_id|
        next unless user_id.present?

        @punishment = Punishment.new(punishment_params)
        user = User.find(user_id)
        user.update(points: user.points -= @punishment.points)
        @punishment.user = user
        @punishment.save
      end
      redirect_to punishments_path(user_son: user_ids[2])
    else
      render :index
    end
  end

  private

  def punishment_params
    params.require(:punishment).permit(:title, :points, :date)
  end

  def set_user_family
    @user = current_user
    @user_family = User.where(family_id: @user.family).where.not(id: @user.id)
  end
end
