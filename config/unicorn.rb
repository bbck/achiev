worker_processes 4
working_directory "/home/achiev/current"
listen "/home/achiev/shared/sockets/unicorn.sock", :backlog => 64
timeout 30
pid "/home/achiev/shared/pids/unicorn.pid"
stderr_path "/home/achiev/shared/log/unicorn.stderr.log"
stdout_path "/home/achiev/shared/log/unicorn.stdout.log"
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  
  old_pid = "/home/achiev/shared/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  
  Rails.cache.reconnect
end
