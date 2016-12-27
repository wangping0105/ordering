# source 'https://rubygems.org'
source 'https://ruby.taobao.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use sqlite3 as the database for Active Record
gem 'mysql2', '~> 0.3.18'
gem 'devise'
gem 'bootstrap-sass', '2.3.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-validation-rails', '~> 1.13.1'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
# issues #169
gem 'rails-backbone', github: 'codebrew/backbone-rails', branch: 'master'

gem 'dragonfly', '~> 1.0.10'

gem 'kaminari', '~> 0.16.3'
#gem 'ruby-audio' ,source: "http://gemcutter.org"

gem 'settingslogic'
# 时间统计
gem 'rack-mini-profiler'
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
# gem 'chinese_pinyin'
gem 'ruby-pinyin', '~> 0.4.7'
# 权限
gem 'pundit', '~> 1.0.1'
# 软删除
gem 'paranoia', '~> 2.1.0'
# Use unicorn as the app server
group :production do
  gem 'unicorn'
  gem "unicorn-worker-killer"
  gem 'newrelic_rpm'
end

# Use Capistrano for deployment
group :development do
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rails', '~> 1.1.3'
  gem 'capistrano3-unicorn', '~> 0.2.1'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-sidekiq'
end

# To use debugger
group :development do
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'pry-nav'
  # gem 'debugger'
  gem 'thin'
  gem "quiet_assets"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
