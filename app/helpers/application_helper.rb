module ApplicationHelper

  def custom_form_for(object, options = {}, &block)
    options[:builder] = CustomerFormBuilder
    form_for(object, options, &block)
  end

  # 头部的信息提示
  def body_head_msg
    if current_order_time.present?
      unless current_user.orders.current_orders.present?
        types = "danger"
        msg = "小提示：您今天还未订饭哦～不点就没的吃咯"
      else
        types = "success"
        msg = " 小提示：您已经点了【#{current_user.orders.current_orders.first.meal.try(:name)}】#{ "等套餐" if current_user.orders.current_orders.size>1}，耐心等待吧!"
      end
    else
      types = "danger"
      msg = "提示："
      if current_user.orders.current_orders.present?
        msg += "你本次点的是【#{current_user.orders.current_orders.first.meal.try(:name)}】#{ "等套餐" if current_user.orders.current_orders.size > 1 },"
      end
      msg += "订饭已经结束咯～"
    end

    {
      types: types,
      msg: msg
    }
  end

  def nav_bar_active(_controller_name, _action_name = nil)
    if controller_name == _controller_name && (action_name == _action_name || _action_name.blank?)
      "active"
    end
  end
  
end
