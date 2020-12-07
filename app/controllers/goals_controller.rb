class GoalsController < ApplicationController
  before_action :set_user_family, only: %i[index]

  def index
    @selected_son = params[:user_son]

    if @selected_son.present?
      @son = User.find(@selected_son)
      @son_goals = Goal.where(user_id: @selected_son, finished: false)
      @son_goals_finished = Goal.where(user_id: @selected_son, finished: true)
    end
  end

  def add_points
    goal = Goal.find(params[:id])
    user = goal.user
    if user.points <= 0
      redirect_to goals_path(user_son: goal.user_id), alert: "Você não tem pontos"
    else
      remaining_points_to_finish = goal.total_points - goal.points
      if user.points > remaining_points_to_finish
        goal.update(points: remaining_points_to_finish)
        user.update(points: user.points - remaining_points_to_finish)
      else
        goal.update(points: goal.points += user.points)
        user.update(points: 0)
      end
      redirect_to goals_path(user_son: goal.user_id)
    end
  end

  private

  def set_user_family
    @user = current_user
    @user_family = User.where(family_id: @user.family).where.not(id: @user.id)
  end
end
