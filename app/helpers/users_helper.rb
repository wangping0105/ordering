module UsersHelper
  def signeed_in(user)
    remember_token = user.id
    cookies.permanent[:remember_token] = remember_token
    self.current_user = user
  end

  def signed_out
    cookies.permanent[:remember_token] = nil
    self.current_user = nil
  end

  def current_order_time
    @remember_token ||= Shop.first.remember_order_time
  end

  def validate_admin
    unless current_user.admin?
      flash[:error] = '你无权操作哦！'
      redirect_to root_path
    end
  end

  def is_readonly(user)
    !(current_user.admin? || (!user.phone.present? && !current_user.admin?))
  end

end
