set :rvm_ruby_string, :release_path
#set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local system
set :rvm_type, :system
require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, "ticketee"
set :repository,  "git://github.com/zzwzzhao/ticketee.git"

set :scm, :git
set :user, "ticketeeapp.com"
set :deploy_to, "/home/ticketeeapp.com/apps/#{application}"
set :use_sudo, false
set :keep_releases, 5
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.33.10"                          # Your HTTP server, Apache/etc
role :app, "192.168.33.10"                          # This may be the same as your `Web` server
role :db,  "192.168.33.10", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

 task :symlink_database_yml do
   run "rm #{release_path}/config/database.yml"
   run "ln -sfn #{shared_path}/config/database.yml #{release_path}/config/database.yml"
 end

 after "bundle:install", "symlink_database_yml"
