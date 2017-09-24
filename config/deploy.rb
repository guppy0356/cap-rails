# config valid only for current version of Capistrano
lock "3.9.1"

server ENV['AWESOME_IP_ADDR'], port: 2123, roles: [:app, :web, :db], primary: true

set :application, "cap-rails"
set :repo_url, "https://github.com/guppy0356/cap-rails.git"

# user
set :user,            'deploy'
set :use_sudo,        false

# puma
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

# terminal
set :pty,             true

# server
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/var/www/rails/#{fetch(:application)}"

# ssh
set :ssh_options,     {
  user: 'deploy'
}

# rvm
set :rvm_ruby_version, 'ruby-2.4.1@cap-rails'

# environment
# ref https://github.com/capistrano/rails#symlinks
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/uploads'
)
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/secrets.yml'
)
