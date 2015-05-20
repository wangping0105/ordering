set :user , 'deploy' #cap deploy 的操作用户
set :deploy_to , '/opt/projects/ordering'  #服务器上面的项目的位置
set :current_path , "#{deploy_to}/current"
set :shared_path , "#{deploy_to}/shared"
set :web , "116.255.202.113"
set :app , "116.255.202.113"
set :db , "116.255.202.113", :primary => true # This is where Rails migrations will run
set :rails_evn ,"production"