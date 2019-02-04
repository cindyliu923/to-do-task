module TasksHelper
  def deadline_order
    if params[:order] == 'deadline_asc'
      tasks_path(:order => "deadline_desc")
    else
      tasks_path(:order => "deadline_asc")
    end
  end
end
