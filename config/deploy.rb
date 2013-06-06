#require 'capistrano/ext/multistage'
#require 'bundler/capistrano'
#require 'rvm/capistrano'

set :application, "/var/www/enods.com/public_html"
set :repository,  "git@github.com:neeraji2it/enods.git"
set :git_enable_submodules, 1 # if you have vendored rails
set :scm, :git
set :scm_user, "ubuntu"
set :scm_verbose, true
# roles (servers)
role :web, '54.214.252.107'
role :app, '54.214.252.107'
role :db,  '54.214.252.107', :primary => true

# deploy config
set :deploy_to, application
set :deploy_via, :export
 

desc "Symlinks database.yml, mailer.yml file from shared directory into the latest release"
task :symlink_shared, :roles => [:app, :db] do
  run "ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
end

after 'deploy:finalize_update', :symlink_shared

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end