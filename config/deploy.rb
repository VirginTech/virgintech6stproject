require "bundler/capistrano"

set :application, "virgintech6stproject"
set :rails_env, "production"

server "133.130.98.121", :web, :app, :db, primary: true

set :repository, "git@github.com:VirginTech/virgintech6stproject.git"
set :scm, :git
set :branch, "master"
set :user, "virgintech"
set :use_sudo, false
set :deploy_to, "/home/#{user}/workspace/virgintech6stproject"
set :deploy_via, :remote_cache
ssh_options[:port] = 37876
ssh_options[:forward_agent] = true