class TasksController < ApplicationController
  before_action :set_user_family, only: %i[index new]

  def index
    @selected_son = params[:user_son]

    if @selected_son.present?
      @family_tasks_school = Task.where(user_id: @selected_son, home: true)
      @family_tasks_home = Task.where(user_id: @selected_son, home: false)
    # else
    #   @family_tasks_school = Task.where(user_id: @user_family, task_type: "Escola")
    #   @family_tasks_home = Task.where(user_id: @user_family, task_type: "Casa")
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    user_ids = params[:task][:user_id]

    if @task.valid? && user_ids.count >= 2
      user_ids.each do |user_id|
        next unless user_id.present?

        @task = Task.new(task_params)
        user = User.find(user_id)
        @task.user = user
        @task.save
      end
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_user_family
    @user = current_user
    @user_family = User.where(family_id: @user.family).where.not(id: @user.id)
  end

  def task_params
    params.require(:task).permit(:title, :deadline, :points, :home)
  end
end
