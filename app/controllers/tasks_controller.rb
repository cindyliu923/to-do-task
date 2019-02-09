class TasksController < ApplicationController
  before_action { authorize! :manage, Task }
  before_action :set_task, :only => [:show, :edit, :update, :destroy, :up, :down]
  before_action :search_task, :except =>[:up, :down]

  def index
    @tasks = @q.result.includes(:tags).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      flash[:notice] = I18n.t("tasks.notice.create")
      redirect_to tasks_url
    else
      flash.now[:alert] = I18n.t("tasks.alert.create")
      render :action => :new
    end
  end

  def update
    if @task.update_attributes(task_params)
      flash[:notice] = I18n.t("tasks.notice.update")
      redirect_to task_path(@task)
    else
      flash.now[:alert] = I18n.t("tasks.alert.update")
      render :action => :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url
    flash[:alert] = I18n.t("tasks.alert.destroy")
  end

  def up
    @task.up!
    redirect_back(fallback_location: root_path)
  end

  def down
    @task.down!
    redirect_back(fallback_location: root_path)
  end

  private

  def set_task
    @task = Task.find(params[:id])
    unless @task.user == current_user
      flash[:alert] = I18n.t("tasks.alert.permit")
      redirect_to root_path
    end
  end

  def search_task
    @q = current_user.tasks.ransack(params[:q])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :priority, { tag_items: [] })
  end

end
