# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.12.0'

# Change these
server 'icmoc.com', part: 22, roles: %i[web app db], primary: true

set :repo_url,        'https://github.com/encoreshao/icmoc-erp'
set :application,     'erp'
set :rvm_type,        :system
set :rvm_ruby_version, "2.6.5@#{fetch(:application)}"

set :user,          ENV['CAPISTRANO_USER'] || `whoami`.chop
set :tmp_dir,       "/home/#{fetch(:user)}/tmp"
set :format,        :pretty
set :log_level,     :debug

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false

set :deploy_via,      :remote_cache
set :deploy_to,       "/var/www/production/#{fetch(:application)}"

set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub] }

# Puma
set :puma_threads,    [1, 4]
set :puma_workers,    1
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord

# Linked Files & Directories (Default None):
append :linked_dirs, 'log', '.bundle', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle', 'public/uploads'
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/app_config.yml'

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke('puma:restart')
    end
  end

  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
