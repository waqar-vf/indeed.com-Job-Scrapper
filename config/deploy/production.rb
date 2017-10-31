role :app, %w{deploy@212.111.41.48}
role :web, %w{deploy@212.111.41.48}
role :db, %w{deploy@212.111.41.48}
set :deploy_to, '/home/deploy/projects/lunchbox'
set :rvm_ruby_version, 'ruby-2.2.2@slingshots'
set :branch, 'production'
server '212.111.41.48', user: 'deploy', roles: %w{web app}, my_property: :my_value
server '212.111.41.48',
       user: 'deploy',
       roles: %w{web app},
       ssh_options: {
           user: 'deploy', # overrides user setting above
           keys: %w(/home/muaaz/.ssh/id_rsa),
           forward_agent: true,
           auth_methods: %w(publickey)
       }
namespace :paths do
  desc "Link paths of required files"
  task :link_paths do
    run "ln -sf #{shared_path}/uploads #{release_path}/public/uploads"
  end
end
