require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Ordering
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Beijing'
    # config.active_record.default_timezone # 存的时候用utc
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.load_path += Dir[File.join(Rails.root.to_s, 'config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:"zh-CN", :zh, :en]
    config.i18n.default_locale = "zh-CN"

    # 参考 http://robbinfan.com/blog/40/ruby-off-rails, 去除不必要的东西
    config.middleware.delete 'Rack::Cache'   # 整页缓存，用不上

    # 记录X-Request-Id（方便查看请求在群集中的哪台执行）只有在大型应用部署在群集环境下进行线上调试才可能用到的功能，有什么必要做成默认的功能呢
    config.middleware.delete 'ActionDispatch::RequestId'

    config.middleware.delete 'ActionDispatch::RemoteIp'  # IP SpoofAttack
    config.middleware.delete 'ActionDispatch::Head'      # 如果是HEAD请求，按照GET请求执行，但是不返回body
  end
end

$This_is_messages = {}