class UsersController < ApplicationController
  before_action :validate_admin, only: [:index, :destroy]
  DEFAULT_PASSWORD = "111111"

  def index
    @users = User.page(params[:page]).per(params[:per_page])
    if params[:query].present?
      @users = @users.like_any_fields(params[:query], :username, :truename)
    end
    @all_phones =all_phones
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    OperationLog.create(user: current_user, action: :show, loggable: @user, note: ("查看自己的信息" if @user == current_user))
    render 'new'
  end

  def show
    @user ||= current_user
    render 'new'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "删除成功！"
    OperationLog.create(user: current_user, action: :delete, loggable: @user, note: "软删除用户")
    redirect_to users_path(page: params[:page])
  end

  def reset_default_password
    @user = User.find(params[:id])
    @user.password = DEFAULT_PASSWORD
    if @user.save
      flash[:success] = "密码成功重置为: #{DEFAULT_PASSWORD}"
    end
    redirect_to users_path(page: params[:page])
  end

  def add_user
    @user = User.find(params[:id]) unless params[:id].blank?
    unless @user
      @user = User.new(user_params)
      flag = @user.save!
      OperationLog.create(user: current_user, action: :create, loggable: @user)
    else
      OperationLog.create(user: current_user, action: :update, loggable: @user, note: ("更新自己的信息" if @user == current_user))
      flag = @user.update(user_params)
    end

    if flag
      path = unless current_user.admin?
        user_path(@user)
      else
        users_path(page: params[:page])
      end
      data = {code: 0, msg: "保存成功", url: path}
    else
      data = {code: -1, msg: "保存失败,#{@user.errors.full_messages.join(",")}"}
    end

    render json: data
  end

  def pay
    user = User.find_by(id: params[:id])
    user.update_attribute(:status, 1) if user

    redirect_to orders_path
  end

  def notice
    flash[:success] = '此功能已经移除了'
    redirect_to action: :index
  end

  private
  def user_params
    params.require(:user).permit(:phone, :password, :email, :username, :truename)
  end

  def all_phones
    {}
  end

  def demo
    phones = {"123"=>15721462117}
    User.find_each do |u|
      _phone = phones[u.truename]
      p phones[u.truename]
      if _phone
        u.update(phone: _phone)
      end
    end
  end

end
