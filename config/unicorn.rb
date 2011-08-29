worker_processes 4
working_directory "/home/achiev/current"
listen "/home/achiev/shared/sockets/unicorn.sock", :backlog => 64
timeout 30
pid "/home/achiev/shared/pids/unicorn.pid"
stderr_path "/home/achiev/shared/log/unicorn.stderr.log"
stdout_path "/home/achiev/shared/log/unicorn.stdout.log"
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
