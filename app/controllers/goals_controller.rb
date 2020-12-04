class GoalsController < ApplicationController
  before_action :set_user_family, only: %i[index]

  def index
    @selected_son = params[:user_son]

    if @selected_son.present?
      @son = User.find(@selected_son)
      @son_goals = Goal.find_by(user_id: @selected_son, finished: true)
      @son_goals_finished = Goal.find_by(user_id: @selected_son, finished: false)
    end
  end

  private

  def set_user_family
    @user = current_user
    @user_family = User.where(family_id: @user.family).where.not(id: @user.id)
  end
end
