module Search
  extend ActiveSupport::Concern

  def search_task
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @q = @user.tasks.ransack(search_params)
    elsif current_user.present?
      @q = current_user.tasks.ransack(search_params)
    else
      @q = nil
    end
  end

  private

  def search_params
    params.fetch(:q, {})&.permit(:s, :title_cont, :tags_name_eq, :status_eq)
  end

end
