# Override Capistrano install task
load File.expand_path('../tasks/setup.rake', __FILE__)

# Load nginx task
load File.expand_path('../tasks/nginx/nginx.rake', __FILE__)

# Load puma task
load File.expand_path('../tasks/puma/puma.rake', __FILE__)

# Load postgresql task
load File.expand_path('../tasks/postgresql/postgresql.rake', __FILE__)

# Load server setup task
load File.expand_path('../tasks/setup.rake', __FILE__)
