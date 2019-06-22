# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "check-jenkins"
set :repo_url, "git@gitlab.com:lexuantrung92/check-jenkins.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/check-jenkins"

set :rbenv_type, :system
set :rbenv_ruby, '2.4.1'
set :rbenv_path, '/home/ubuntu/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

namespace :deploy do    
  desc 'Symlinks Secret.yml to the release path'
  task :secret_symlink do
    on roles(:app) do
      execute "sudo ln -nfs #{shared_path}/secrets.yml #{release_path}/config/secrets.yml"
   end
  end

  after  :updating,     :secret_symlink
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

namespace :logs do
  desc 'Tail application logs'
  task :tail_app do
    on roles(:app) do
   		execute "tail -f #{shared_path}/log/#{fetch(:stage)}.log"
 		end
	end
end
