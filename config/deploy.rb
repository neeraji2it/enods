#require 'capistrano/ext/multistage'
#require 'bundler/capistrano'
#require 'rvm/capistrano'

set :application, "/var/www/enods.com/public_html"
set :repository,  "git@github.com:neeraji2it/enods.git"
set :git_enable_submodules, 1 # if you have vendored rails
set :scm, :git
set :use_sudo, false
ssh_options[:keys] = ["/home/ashok/.ssh/enod_key123.pem"]
set :user, 'ubuntu'
set :scm_verbose, true
default_run_options[:pty] = true 
# roles (servers)
role :web, '54.214.252.107'
role :app, '54.214.252.107'
role :db,  '54.214.252.107', :primary => true

# deploy config
set :deploy_to, application
#set :deploy_via, :export
 
desc "Link to the configuration"
task :symlink do
  run "ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  #run "ln -s #{shared_path}/public/uploaded_files #{latest_release}/public/uploaded_files"

end
after "deploy:update_code", :symlink
 
#after 'deploy:finalize_update', :symlink_shared

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