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
    user = OrderUser.find_by(uname:params[:id])
    user.update_attribute(:status,1)

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
    case params[:sender]
    when 'sms'
      sms_sender = SmsSender.new
      sms_sender.singleSend(params[:phone], params[:content])
    when 'voice'
      voice = YunTongXun::VoiceVerify.new
      voice.send_verify_code(params[:phone], "nydfm")
    end
    flash[:success] = '发送成功'
    redirect_to action: :all_users
  end

  private

  def all_phones
    {
        蒋海军:15721462117,
        余永松:13460298021,
        阮大胜:13671667189,
        刘鑫:18602804283,
        胡伟:15000410210,
        蔡莹:18601785971,
        曾琪:18664311447,
        梁苗:15802126641,
        袁野:15121099242,
        徐超:18621666772,
        王道品:18621601475,
        胡明月:15800692660,
        周文精:13636513588,
        余淼:13818338937,
        邱观旭:15058109020,
        路娜:18909247420,
        崔玉魁:13022189206,
        龙滟亮:18601667885,
        黄烨:15921690493,
        王平:15921076830,
        刘源:15921049093,
        姚华:13924190159,
        陈培钦:18801918920,
        丁涛:13127500928,
        曹洋洋:18612648107,
        孙飘:18301770556,
        肖亚:15618387383,
        张桂林:15201866442,
        陈海虎:18616724229,
        李福中:15821940120,
        姚佳丽:13501795706,
        刘超:18851321975,
        贾玉洁:18301827368,
        李辉:13262902619,
        毛鹏:13611861192,
        徐国荣:18616023917,
        周志华:13916045504
    }
  end

end
