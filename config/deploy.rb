require 'bundler/capistrano'
require 'rvm/capistrano'
require 'capistrano/rails/assets'

set :application, "sanyam"
set :repository,  "git@github.com:manish-johari/sanyam.git"

# set :rails_env, 'development'

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "localhost"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
role :db,  "localhost", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :use_sudo, false
set :user, "kiwitech"

set :deploy_to, "/home/kiwitech/rails_projects/self_learning/deploy_sanyam"
set :keep_releases, 5


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

# namespace :deploy do
# 	# Apache needs to be restarted to make sure that the APC cache is cleared.
# 	# This overwrites the :restart task in the parent config which is empty.
# 	desc "Restart Apache"
# 	task :restart, :except => { :no_release => true }, :roles => :app do
# 		#run "sudo service apache2 restart"
# 		run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
# 		puts "--> Apache successfully restarted".green
# 	end
# end


# default_run_options[:pty] = true


#run "bundle exec rake db:migrate"

after "deploy:update_code", "deploy:migrate"
# set :rake, "bundle exec rake"


# task :assets_precompile do
# 	puts "================#{current_path}--------"
#   puts "----Precompiling assets----"
#   run "cd #{deploy_to}/current && RAILS_ENV=production bundle exec rake assets:precompile --trace"
#   puts `rake assets:clean`
# end

# after "deploy", "assets_precompile"
