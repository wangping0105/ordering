class EvaluationsController < ApplicationController
  def create
    evaluation = current_user.evaluations.find_by(evaluatable_id: this_params[:evaluatable_id], evaluatable_type: this_params[:evaluatable_type])
    unless evaluation.present?
      evaluation = current_user.evaluations.new(this_params)
    else
      evaluation.types = this_params[:types]
    end

    if evaluation.save
      render json:{code: 0, message: '评论成功'}
    else
      render json:{code: -1, message: '评论失败'}
    end
  end

  private
  def this_params
    _data = params.require(:evaluation).permit(:evaluatable_id, :evaluatable_type, :types)
    _data[:types] = _data[:types].to_i
    _data
  end
end
