set :application, "brio"
set :repository,  "git@github.com:brittballard/brio.git"
set :deploy_to,    "/var/rails/#{fetch(:application)}"
set :keep_releases, false
set :use_sudo, false

set :scm, :git
set :user, "deploy"

before "deploy", "deploy:check"
after "deploy", "deploy:migrate"
