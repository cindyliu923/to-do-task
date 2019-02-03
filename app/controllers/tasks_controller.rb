class TasksController < ApplicationController
  before_action :set_task, :only => [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end

end
