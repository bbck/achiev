require "bundler/capistrano"
require "whenever/capistrano"

set :application,      "achiev"
set :repository,       "git@github.com:bbck/achiev.git"
set :scm,              :git
set :branch,           "master"
set :deploy_via,       :remote_cache
set :use_sudo,         false
set :user,             "achiev"
set :deploy_to,        "/home/#{user}"
set :unicorn_pid,      "#{shared_path}/pids/unicorn.pid"
set :unicorn_config,   "#{current_path}/config/unicorn.rb"
set :ssh_options,      { :forward_agent => true }
set :whenever_command, "bundle exec whenever"
set :default_environment, {
  'PATH' => "/home/achiev/.rbenv/shims:/home/achiev/.rbenv/bin:$PATH"
}

role :web, "achiev.bbck.net"
role :app, "achiev.bbck.net"
role :db,  "achiev.bbck.net", :primary => true

namespace :deploy do
  desc "Symlink configuration files"
  task :configs do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  end
  
  desc "Restart Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end

  desc "Start Unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec unicorn_rails -c #{unicorn_config} -D"
  end

  desc "Stop Unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{unicorn_pid}`"
  end
end

after "deploy:finalize_update", "deploy:configs"
