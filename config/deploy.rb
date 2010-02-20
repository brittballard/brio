set :application, "brio"
set :repository,  "git@github.com:brittballard/brio.git"
set :deploy_to,    "/var/rails/#{fetch(:application)}"
set :keep_releases, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "deploy"

role :web, "sweetboyalliance.com"                          # Your HTTP server, Apache/etc
role :app, "sweetboyalliance.com"                          # This may be the same as your `Web` server
role :db,  "sweetboyalliance.com", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end