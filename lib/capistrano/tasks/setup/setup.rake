# Setup all the necessary server side services for the first time
# when an app is being deployed
namespace :setup do

  desc "Configure the database and role for this application"
  task :postgresql do
    invoke "postgresql:create_role"
    invoke "postgresql:create_db"
    on roles(:app) do
      from = File.expand_path("../../../templates/postgresql/database.yml.erb", __FILE__)
      to = File.join(shared_path, 'config/database.yml')
      execute :mkdir, '-pv', "#{shared_path}/config"
      upload_template(from, to)
    end
  end

  desc 'add site, enable and reload nginx'
  task :nginx do
    invoke 'nginx:site:add'
    invoke 'nginx:site:enable'
    invoke 'nginx:restart'
  end

  desc 'create folders for deploy on server and configure nginx and postgres'
  task :all do
    on roles(:app) do
      invoke 'deploy:check:directories'
      invoke 'deploy:check:linked_dirs'
      invoke 'setup:nginx'
      invoke 'setup:postgresql'
      invoke 'setup:dotenv'
    end
  end

  desc 'create a dotenv file for secure environment data'
  task :dotenv do
    on roles(:app) do
      from = File.expand_path("../../../templates/dotenv.erb", __FILE__)
      to = File.join(shared_path, '.env')
      upload_template(from, to)
    end
  end

  def upload_template(from, to)
    erb = File.read(from)
    upload! StringIO.new(ERB.new(erb).result(binding)), to
  end

end
