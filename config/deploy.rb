require 'bundler/capistrano'

set :rails_env, ENV['RAILS_ENV'] || 'staging'
set :application, ENV['HOST'] || 'tsushin.vagrant.vm'

set :deploy_to, "/var/www/#{application}"
role :web, "#{application}"
role :app, "#{application}"
role :db, "#{application}", :primary => true

default_run_options[:pty] = true

ssh_options[:forward_agent] = false
set :user, 'capistrano'
set :use_sudo, false
set :copy_exclude, %w(.git jetty feature spec tmp vagrant config/application.local.rb)


if fetch(:application).end_with?('vagrant.vm')
  set :scm, :none
  set :repository, '.'
  set :deploy_via, :copy
  set :copy_strategy, :export
  ssh_options[:keys] = [ENV['IDENTITY'] || './vagrant/puppet-applications/vagrant-modules/vagrant_capistrano_id_dsa']
else
  set :deploy_via, :remote_cache
  set :scm, :git
  set :scm_username, ENV['CAP_USER']
  set :repository, ENV['SCM']
  if variables.include?(:branch_name)
    set :branch, "#{branch_name}"
  else
    set :branch, 'master'
  end
  set :git_enable_submodules, 1
end

# tasks

before "deploy:assets:precompile", "config:symlink"
after "deploy:update", "deploy:cleanup"

namespace :config do
  desc "linking configuration to current release"
  task :symlink do
    run "ln -nfs #{deploy_to}/shared/config/application.local.rb #{release_path}/config/application.local.rb"
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
