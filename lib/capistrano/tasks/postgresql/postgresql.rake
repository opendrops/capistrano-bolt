namespace :load do
  task :defaults do
    set :postgresql_admin, "postgres"
    set :postgresql_host, "localhost"
    set :postgresql_user, -> { "#{fetch(:application)}_#{fetch(:stage)}".downcase }
    set :postgresql_password, SecureRandom.hex(40)
    set :postgresql_database, -> { "#{fetch(:application)}_#{fetch(:stage)}".downcase }
  end
end

namespace :postgresql do

  desc "Create the database role for this application"
  task :create_role do
    on primary(:db) do
      output = capture "sudo -u #{fetch(:postgresql_admin)} psql postgres -tAc \"SELECT 1 FROM pg_roles WHERE rolname='#{fetch(:postgresql_user)}'\""
      if !output.empty?
        abort "User already exists."
      else
        info "User does not exist. Creating a new one with password #{fetch(:postgresql_password)}"
        execute %Q{sudo -u #{fetch(:postgresql_admin)} psql -c "create user #{fetch(:postgresql_user)} with password '#{fetch(:postgresql_password)}';"}
      end

    end
  end

  desc "Create the database for this application"
  task :create_db do
    on primary(:db) do
      output = capture "sudo -u #{fetch(:postgresql_admin)} psql -tAc \"SELECT 1 FROM pg_database WHERE datname='#{fetch(:postgresql_database)}'\""
      if !output.empty?
        warn "Database already exists. Using the existing one."
      else
        info "Database does not exist. Creating a new one."
        execute %Q{sudo -u #{fetch(:postgresql_admin)} createdb "#{fetch(:postgresql_database)}" -O "#{fetch(:postgresql_user)}"}
      end

    end
  end

end
