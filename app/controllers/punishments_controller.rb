class PunishmentsController < ApplicationController

  def index
    @selected_son = params[:user_son]
    if @selected_son.present?
      @son = User.find(@selected_son)
      @son_punishments = Punishment.where(user_id: @selected_son).order(date: :desc)
    end
  end

  def new
    @punishment = Punishment.new
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
      redirect_to punishments_path(user_son: @punishment.user_id)
    else
      render :index
    end
  end

  private

  def punishment_params
    params.require(:punishment).permit(:title, :points, :date)
  end
end
