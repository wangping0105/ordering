module YunTongXun

  # http://www.yuntongxun.com/activity/smsIdentifying#tiyan
  class VoiceVerify
    attr_accessor :app_id, :account_sid, :auth_token, :timestamp, :authorization, :sig_parameter, :voice_verify_uri

    def initialize
      self.app_id = AppSettings.yuntongxun_app_id
      self.account_sid = AppSettings.yuntongxun_account_sid
      self.auth_token = AppSettings.yuntongxun_auth_token
      self.timestamp = Time.now
      self.authorization = Base64.encode64("#{account_sid}:#{timestamp.strftime('%Y%m%d%H%M%S')}").gsub!("\n", '')
      self.sig_parameter = Digest::MD5.hexdigest("#{account_sid}#{auth_token}#{timestamp.strftime('%Y%m%d%H%M%S')}").upcase
      self.voice_verify_uri = "/2013-12-26/Accounts/#{account_sid}/Calls/VoiceVerify?sig=#{sig_parameter}"
    end

    # to: 接收号码，被叫为座机时需要添加区号，如：01052823298；被叫为分机时分机号由'-'隔开，如： 01052823298-3627
    # 成功返回: {"statusCode"=>"000000", "VoiceVerify"=>{"dateCreated"=>"2015-08-12 16:46:53", "callSid"=>"1508121646532778000600060000d612"}}
    # 失败返回: {"statusMsg"=>"【呼叫】应用未上线，语音验证码被叫号码外呼受限", "statusCode"=>"111324"}
    def send_verify_code(to,  verify_code)
      timestamp  = Time.now

      url = URI(AppSettings.yuntongxun_host)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true if url.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      payload ={
          "appId" => "#{app_id}",
          "verifyCode" => "#{verify_code}",
          "playTimes" => "2",
          "to"=>"#{to}"
        }.to_json

      # def post
      req = Net::HTTP::Post.new(voice_verify_uri, initheader = {
        "Content-Type" => "application/json;charset=utf-8",
        "Accept" => "application/json",
        'Authorization' => authorization
      })

      # req.basic_auth user, pass
      req.body = payload
      response = http.start {|http| http.request(req) }
      puts data = JSON.parse(response.body)

      data["statusCode"].eql?("000000") rescue data["statusMsg"]
    end

  end

end

# voice = YunTongXun::VoiceVerify.new
# voice.send_verify_code '18621666772', '112233'
