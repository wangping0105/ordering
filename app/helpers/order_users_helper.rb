module OrderUsersHelper
  def signeed_in(user)
    remember_token = user.id
    cookies.permanent[:remember_token] = remember_token
    self.current_order_user = user
  end
   def current_order_user=(user)
    @current_order_user = user
  end

  def current_order_user
    remember_token =cookies[:remember_token]
    @current_order_user ||= OrderUser.find(remember_token)
  end
end
