# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "paga3"
set :repo_url, "git@github.com:acholis/paga3.git"

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads', 'public/packs', 'node_modules'

# Only keep the last 5 releases to save disk space
set :keep_releases, 5

set :passenger_restart_with_touch, true

# ==========================================================================
# ==========================================================================
# ==========================================================================
# if you haven't already specified
set :rails_env, "production"

# if you want to remove the local dump file after loading
set :db_local_clean, true

# if you want to remove the dump file from the server after downloading
set :db_remote_clean, true

# if you want to exclude table from dump
set :db_ignore_tables, []
set :db_ignore_data_tables, []
set :db_dump_dir, "./db"
set :assets_dir, %w(public/assets public/att)
set :local_assets_dir, %w(public/assets public/att)

# if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
set :locals_rails_env, "production"

# if you are highly paranoid and want to prevent any push operation to the server
set :disallow_pushing, true

# if you prefer bzip2/unbzip2 instead of gzip
set :compressor, :bzip2