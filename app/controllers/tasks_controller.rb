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
    user = User.find(@task.user_id)
    if current_user.admin?
      @task.update(finished: true, validated: true)
      user.update(points: user.points += @task.points)
      message_body = "A tarefa de #{@task.user.name} foi validada 🎉 ! Ganhou #{@task.points} ⭐ !!!"
      user_phone = user.phone
      @message = Message.create(
        content: message_body,
        chatroom_id: @task.user.family.chatroom.id,
        user_id: user.family.users.find_by(admin: true).id
      )
    else
      @task.update(finished: true)
      message_body = "#Finalizei a tarefa #{@task.title} 🎉! Aguarda a sua validação!!!"
      user_phone = user.family.users.find_by(admin: true).phone

      @message = Message.create(
        content: message_body,
        chatroom_id: @task.user.family.chatroom.id,
        user_id: user.user_id
      )
    end
    ChatroomChannel.broadcast_to(
      @task.user.family.chatroom,
      { message: { user_id: @message.user.id,
                   name: @message.user.name,
                   message_id: @message.id,
                   date: @message.created_at.strftime("%a %b %e at %l:%M%p"),
                   content: @message.content } }
    )
    twilio_client(message_body, user_phone)
    redirect_to tasks_path(user_son: @task.user_id)
  end

  private

  def task_params
    params.require(:task).permit(:title, :deadline, :points, :home)
  end

  def twilio_client(message_body, user_phone)
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    message = @client.messages.create(
      body: message_body,
      from: 'whatsapp:+14155238886',
      to: "whatsapp:#{user_phone}"
    )
    return message
  end
end
