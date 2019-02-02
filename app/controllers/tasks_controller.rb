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
      flash[:notice] = "task was successfully created"
      redirect_to tasks_url
    else
      flash.now[:alert] = "task was failed to create"
      render :action => :new
    end
  end

  def update
    if @task.update_attributes(task_params)
      flash[:notice] = "task was successfully updated"
      redirect_to task_path(@task)
    else
      flash.now[:alert] = "task was failed to update"
      render :action => :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url
    flash[:alert] = "task was deleted"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end

end
