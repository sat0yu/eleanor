# This file is used by Rack-based servers to start the application.

unless ENV['RAILS_ENV'] == 'development'
  require 'unicorn/worker_killer'
  use Unicorn::WorkerKiller::MaxRequests, 3072, 4096, true
  use Unicorn::WorkerKiller::Oom, (192*(1024**2)), (256*(1024**2)), 16
end

require_relative 'config/environment'

run Rails.application
