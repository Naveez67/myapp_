# frozen_string_literal: true

server '3.88.167.11', user: 'ubuntu', roles: %w[web app db]
set :stage, :production
set :rails_env, :production
set :branch, 'main'
set :ssh_options, {
  keys: %w[~/.ssh/id_rsa],
  forward_agent: false,
  user: 'user'
}