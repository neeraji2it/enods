set :domain, "ec2-54-244-135-57.us-west-2.compute.amazonaws.com"

set :deploy_to, "/var/www/enods.com/public_html"

set :user, "rails"
set :use_sudo, false

set :rails_env, "production"
role :app, "ec2-54-244-135-57.us-west-2.compute.amazonaws.com"
role :web, "ec2-54-244-135-57.us-west-2.compute.amazonaws.com"
role :db,  "ec2-54-244-135-57.us-west-2.compute.amazonaws.com", :primary => true
  
