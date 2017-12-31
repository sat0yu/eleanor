APP_ROOT = '/var/www/eleanor'
APP_SHARED_PATH = "#{APP_ROOT}/shared"

worker_processes 2
preload_app true
timeout 30

listen      "#{APP_SHARED_PATH}/tmp/sockets/unicorn.sock"
pid         "#{APP_SHARED_PATH}/tmp/pids/unicorn.pid"
stderr_path "#{APP_SHARED_PATH}/log/unicorn.stderr.log"
stdout_path "#{APP_SHARED_PATH}/log/unicorn.stdout.log"

before_fork do |server, worker|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', ENV['RAILS_ROOT'])
end

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end

