class OperationLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :loggable,->{with_deleted}, polymorphic: true

  include EntityQueryable

  def action_mapped
    I18n.t("enums.operation_log.action.#{action}")
  end
end
