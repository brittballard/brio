set :application, "brio"
set :repository,  "git@github.com:brittballard/brio.git"
set :deploy_to,    "/var/rails/#{fetch(:application)}"
set :keep_releases, false
set :use_sudo, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "deploy"

server "sweetboyalliance.com", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app do ; end
end

