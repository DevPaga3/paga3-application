require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rails'
require 'capistrano/passenger'
require 'capistrano/rbenv'
require 'capistrano/rails/console'
require 'capistrano-db-tasks'
require "capistrano/scm/git"

set :rbenv_type, :user
set :rbenv_ruby, '2.7.1'

install_plugin Capistrano::SCM::Git
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
