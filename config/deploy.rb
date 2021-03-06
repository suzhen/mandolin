set :application, 'mandolin'
set :repo_url, 'git@github.com:suzhen/mandolin.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch,'master'
set :chruby_ruby, '2.5.3'
set :deploy_to, '/var/www/mandolin'
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/boot_app.yml config/database.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

set :bundle_flags, '--deployment'

set :bundle_gemfile, -> { release_path.join('Gemfile') }

set :bundle_binstubs, nil

namespace :deploy do

  task :restart  do
    on roles(:web),in: :sequence, wait: 3 do
      within release_path do
        execute :bundle,"exec thin restart -C /var/www/mandolin/shared/config/boot_app.yml"
      end
    end
  end

  # desc 'Restart application'
  # task :restart do
  #   on roles(:web), in: :sequence, wait: 5 do
  #     # Your restart mechanism here, for example:
  #     execute :touch, release_path.join('tmp/restart.txt')
  #   end
  # end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     within release_path do
  #       execute :rake, 'cache:clear'
  #     end
  #   end
  # end

  # after :finishing, 'deploy:cleanup'

  after :published, :restart
end
