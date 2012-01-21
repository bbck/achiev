every :hour do
  command "/home/achiev/current/script/failed"
end

every :reboot do
  command "cd /home/achiev/current && bundle exec unicorn_rails -c /home/achiev/current/config/unicorn.rb -D"
  command "cd /home/achiev/current && RAILS_ENV=production BACKGROUND=yes QUEUES=character,guild PIDFILE=/home/achiev/shared/pids/resque.pid bundle exec rake resque:work"
end
