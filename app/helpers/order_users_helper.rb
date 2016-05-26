module OrderUsersHelper
  def signeed_in(user)
    remember_token = user.id
    cookies.permanent[:remember_token] = remember_token
    self.current_order_user = user
  end

  def signed_out
    cookies.permanent[:remember_token] = nil
    self.current_order_user = nil
  end

  def current_order_user=(user)
    @current_order_user = user
  end

  def current_order_user
    remember_token =cookies[:remember_token]
    @current_order_user ||= OrderUser.find_by(id:remember_token)
  end

  def current_order_time
    @remember_token ||= Shop.first.remember_order_time
  end

  def authenticate_user!
    unless current_order_user.present?
      redirect_to root_path
    end
  end

  def is_login?
    if current_order_user.present?
      redirect_to orders_path
    end
  end

end
