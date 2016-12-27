class OperationLogsController < ApplicationController
  def index
    @operation_logs = OperationLog.includes(:loggable).order(id: :desc).page(params[:page]).per(params[:per_page])
    @operation_logs = @operation_logs.select("operation_logs.*, users.username user_name").joins(:user)
    if params[:user_id].present?
      @operation_logs = @operation_logs.where(user_id: params[:user_id])
    end
    @all_users = User.pluck(:truename, :id).insert(0, ["全部", ""])
  end
end
