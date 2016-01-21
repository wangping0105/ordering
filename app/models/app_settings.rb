class AppSettings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
  suppress_errors Rails.env.production?
end
