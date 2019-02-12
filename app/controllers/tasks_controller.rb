class TasksController < ApplicationController
  before_action { authorize! :manage, Task }
  before_action :set_task, :only => [:show, :edit, :update, :destroy, :up, :down]

  def index
    @tasks = @q.result.includes(:tags).order(created_at: :desc).page(params[:page]).per(8)
  end

  def search
    if params[:user_id].present?
      index
      render 'admin/users/show'
    else
      index
      render :index
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      flash[:notice] = I18n.t("tasks.notice.create")
      redirect_to tasks_path
    else
      flash.now[:alert] = I18n.t("tasks.alert.create")
      render :new
    end
  end

  def update
    if @task.update_attributes(task_params)
      flash[:notice] = I18n.t("tasks.notice.update")
      redirect_to task_path(@task)
    else
      flash.now[:alert] = I18n.t("tasks.alert.update")
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
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
      render_unauthorized
    end
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :priority, { tag_items: [] })
  end

end
