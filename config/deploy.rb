# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "eleanor"
set :repo_url, "git@github.com:sat0yu/eleanor.git"
set :branch, ENV['DEPLOY_BRANCH'] || 'master'
set :keep_releases, 3
set :pty, true

set :linked_files, %w{config/database.yml config/secrets.yml config/secrets.yml.key}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}

set :rbenv_type,     :system
set :rbenv_ruby,     "2.5.0"
set :rbenv_path,     "/opt/rbenv"
set :rbenv_prefix,   "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles,    :all

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
set :unicorn_config_path, "#{current_path}/config/unicorn.rb"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  after 'deploy:publishing', :restart
  desc 'restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  before 'deploy:check:linked_files', :upload_linked_files
  desc "Upload linked_files to the shared/config directory."
  task :upload_linked_files do
    on roles(:app) do
      upload! "config/database.yml",    "#{shared_path}/config/database.yml"
      upload! "config/secrets.yml",     "#{shared_path}/config/secrets.yml"
      upload! "config/secrets.yml.key", "#{shared_path}/config/secrets.yml.key"
    end
  end
end
