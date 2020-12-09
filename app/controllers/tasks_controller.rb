class TasksController < ApplicationController
  def index
    if @user.admin?
      @selected_son = params[:user_son]
      if @selected_son.present?
        @family_tasks_school = Task.where(user_id: @selected_son, home: true, validated: false).order(:deadline, :finished)
        @family_tasks_home = Task.where(user_id: @selected_son, home: false, validated: false).order(:deadline, :finished)
      end
    else
      @family_tasks_school = Task.where(user_id: @user.id, home: true, finished: false).order(:deadline, :finished)
      @family_tasks_home = Task.where(user_id: @user.id, home: false, finished: false).order(:deadline, :finished)
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
      redirect_to tasks_path(user_son: @task.user_id), success: "Tarefa criada com sucesso"
    else
      render :new
    end
  end

  def validate
    @task = Task.find(params[:id])
    if current_user.admin?
      @task.update(finished: true, validated: true)
      user = User.find(@task.user_id)
      user.update(points: user.points += @task.points)
      @message = Message.create(
        content: "A tarefa de #{@task.user.name} foi validada! Ganhou #{@task.points}!!!",
        chatroom_id: @task.user.family.chatroom.id,
        user_id: @task.user.family.users.find_by(admin: true).id
      )
    else
      @task.update(finished: true)
      @message = Message.create(
        content: "#Finalizei a tarefa #{@task.title}! Aguarda a sua validação!",
        chatroom_id: @task.user.family.chatroom.id,
        user_id: @task.user_id
      )
    end
    ChatroomChannel.broadcast_to(
      @task.user.family.chatroom,
      render_to_string(partial: "messages/message", locals: { message: @message })
    )
    redirect_to tasks_path(user_son: @task.user_id)
  end

  private

  def task_params
    params.require(:task).permit(:title, :deadline, :points, :home)
  end
end
