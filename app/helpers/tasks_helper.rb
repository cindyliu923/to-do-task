module TasksHelper
  def deadline_order
    if params[:order] == 'deadline_asc'
      tasks_path(:order => "deadline_desc")
    else
      tasks_path(:order => "deadline_asc")
    end
  end

  def pick_task_status(task)
    if task.todo?
      link_to t("tasks.up"), up_task_path(task), method: :patch, remote: true
    elsif task.doing?
      link_to t("tasks.down"), down_task_path(task), method: :patch, remote: true
    else
      ''
    end
  end
end
