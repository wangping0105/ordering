module UserDestroyable
  extend ActiveSupport::Concern

  included do
    acts_as_paranoid without_default_scope: true

    attr_accessor :to_staff_id

    delegate :want_check_entity_names, to: "self.class"

    before_destroy do
      # reset_use_token

      RequestLogPool.where(user_id: id).delete_all if defined? RequestLogPool
    end
  end

  def can_destroy_this?
    is_all_alone? || (is_entity_clear? && is_assist_entity_clear?)
  end

  def is_entity_clear?
    want_check_entity_names.all?{|entity_name| send(entity_name).empty?}
  end

  def is_assist_entity_clear?
    want_check_entity_names.all?{|entity_name|
      _klass = entity_name.classify.safe_constantize
      _klass.try(:assisted_entity?) ? self_assist_for(_klass).empty? : true
    }
  end

  def is_all_alone?
    self.organization.users.with_deleted.where.not(id: id).empty?
  end

  def transfer_entities_to(operator, to_user = nil)
   if self.id != to_user.id
      want_check_entity_names.all?{|entity_name|
        _klass_name = send(entity_name).klass
        _klass_name.mass_transfer(send(entity_name), operator, to_user)
      }
    end
  end

  module ClassMethods
    def want_check_entity_names
      @want_check_entity_names ||= %w(leads customers opportunities contracts)
    end
  end
end
