$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "bundler/capistrano"

set :application, "achiev"
set :repository,  "git@github.com:bbck/achiev.git"
set :scm,         :git
set :branch,      "master"
set :deploy_via,  :remote_cache
set :use_sudo,    false
set :user,        "achiev"
set :deploy_to,   "/home/#{user}"
set :rvm_type,    :user
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

ssh_options[:forward_agent] = true
default_environment["PATH"] = "/home/achiev/.rbenv/shims:/home/achiev/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/"

server "achiev.bbck.net", :app, :web, :db

namespace :deploy do
  desc "Symlink configuration files"
  task :configs do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  end
  
  desc "Start unicorn"
  task :start do
    run "cd #{current_path} && bundle exec unicorn_rails -c #{current_path}/config/unicorn.rb -E #{rails_env} -D"
  end
  
  desc "Stop unicorn"
  task :stop do
    run "kill -s QUIT `cat #{unicorn_pid}`"
  end
  
  desc "Restart unicorn"
  task :restart do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end
end

after "deploy:finalize_update", "deploy:configs"
