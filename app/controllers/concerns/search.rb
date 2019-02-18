module Search
  extend ActiveSupport::Concern

  def search_task
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @q = @user.tasks.ransack(params[:q])
    elsif current_user.present?
      @q = current_user.tasks.ransack(params[:q])
    else
      @q = nil
    end
  end

end
