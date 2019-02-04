module TasksHelper
  def pick_task_status(task)
    if task.todo?
      link_to t("tasks.up"), up_task_path(task), method: :patch
    elsif task.doing?
      link_to t("tasks.down"), down_task_path(task), method: :patch
    else
      ''
    end
  end
end
