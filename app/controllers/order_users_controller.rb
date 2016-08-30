class OrderUsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :is_login?, only:[:index]
  layout 'user' ,only: [:index]
  def index
    @user=OrderUser.new

    # audio = Speech::AudioToText.new("/home/wangping/Downloads/test1.mp3")
    # binding.pry
    # p audio.to_text
  end
  def create
    @user1=OrderUser.find_by(uname:params[:order_user][:uname])
    if @user1.nil?
      @user=OrderUser.new
      @user.uname=params[:order_user][:uname]
      @user.role=0
      if params[:order_user][:uname].size < 15 && @user.save
        signeed_in @user
        redirect_to new_order_path
      else
        flash[:error] = "！！！名字过长"
        redirect_to root_path
      end
    else
      signeed_in @user1
      redirect_to new_order_path
    end
  end
  def pay
    user = OrderUser.find_by(id: params[:id])
    user.update_attribute(:status, 1) if user

    redirect_to orders_path
  end

  def all_users
    @users = OrderUser.all
    @all_phones =all_phones
  end

  def sign_out
    signed_out
    redirect_to root_path
  end

  def notice
    #case params[:sender]
    #when 'sms'
      #sms_sender = SmsSender.new
     # sms_sender.singleSend(params[:phone], params[:content])
   # when 'voice'
      #voice = YunTongXun::VoiceVerify.new
     # voice.send_verify_code(params[:phone], "nydfm")
    #end
    flash[:success] = '发送成功'
    redirect_to action: :all_users
  end

  private

  def all_phones
    {
        蒋海军:11,
        余永松:11,
        阮大胜:11,
        刘鑫:22
    }
  end

end
