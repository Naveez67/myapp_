# config valid for current version and patch releases of Capistrano
set :application, "myapp"
set :repo_url, "https://Naveez67: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@github.com/Naveez67/myapp_"
set :deploy_to, "/home/ubuntu/#{fetch :application}"

# frozen_string_literal: true

# set :application, "docker_test_app"
# set :repo_url, "https://hasannadeem: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@github.com/hasannadeem/docker_test_app.git"
# restart app by running: touch tmp/restart.txt
# at server machine
set :passenger_restart_with_touch, true
set :rails_env, :production
set :puma_threads, [4, 16]
# Don’t change these unless you know what you’re doing
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }
set :keep_releases, 5

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# set :deploy_to, "~/ubuntu/docker_test_app"
namespace :puma do
  desc "Create Directories for Puma Pids and Socket"
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end
namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
  on roles(:app) do
    unless `git rev-parse HEAD` == `git rev-parse origin/main`
      puts "WARNING: HEAD is not the same as origin/main"
      puts "Run `git push` to sync changes."
      exit
    end
  end
end
  desc "Initial Deploy"
    task :initial do
      on roles(:app) do
      before "deploy:restart", "puma:start"
      invoke "deploy"
  end
end
desc "Restart application"
 task :restart do
  on roles(:app), in: :sequence, wait: 5 do
    invoke "puma:restart"
  end
 end
  before :starting, :check_revision
  after :finishing, :compile_assets
  after :finishing, :cleanup
  after :finishing, :restart
end
before "deploy:assets:precompile", "deploy:bundle_install"

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
