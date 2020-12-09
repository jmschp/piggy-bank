class GoalsController < ApplicationController

  def index
    @selected_son = params[:user_son]

    if @selected_son.present?
      @son = User.find(@selected_son)
      @son_goals = Goal.where(user_id: @selected_son, finished: false)
      @son_goals_finished = Goal.where(user_id: @selected_son, finished: true)
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    user_ids = params[:goal][:user_id]

    if @goal.valid? && user_ids.count >= 2
      user_ids.each do |user_id|
        next unless user_id.present?

        @goal = Goal.new(goal_params)
        user = User.find(user_id)
        @goal.user = user
        @goal.save
      end
      redirect_to goals_path(user_son: @goal.user_id)
    else
      render :new
    end
  end

  def add_points
    goal = Goal.find(params[:id])
    user = goal.user
    if user.points <= 0
      redirect_to goals_path(user_son: goal.user_id), alert: current_user.admin? ? "Seu kiddo não tem pontos" : "Você não tem pontos"
    else
      remaining_points_to_finish = goal.total_points - goal.points
      if user.points > remaining_points_to_finish
        goal.update(points: goal.points + remaining_points_to_finish)
        user.update(points: user.points - remaining_points_to_finish)
      else
        goal.update(points: goal.points += user.points)
        user.update(points: 0)
      end
      redirect_to goals_path(user_son: goal.user_id)
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :total_points)
  end
end
