# Heroku-like easy deployment for Rails 4 with Capistrano 3, Puma, Nginx and Postgresql.

**UPDATE:** A very brief documentation is updated at the end of this readme after noticing that many people are trying this gem within few hours of publishing. Thanks for the support guy but sorry for publising the gem without getting the documentation ready at first place.

As the title says, this gem provides a super simple way to deploy your rails app.
I created this after I got tired of trying numerous capistrano receipes and gem.  While I learned a lot from these gems and respect their authors for the knowledge shared with the community to the core of my heart, none of the existing gems that I tried simplified the deployment process as I wanted. Here is the workflow that I ever wanted.

### Prerequisites
A server that has postgresql, nginx and ruby installed.

### Step 1
Install a gem on my rails app and issue a command like below

```
  cap production setup:all
  cap production deploy
```

### Step 2

NO Step 2. No need to login to the server to create nginx vhost file or postgres database or to create environment variables. All these are already taken care by Step 1.

Note: currently the gem requires a few configuration task in your rails app which will be automated in future.

---

If you are like me and want a simple deployment process like above then this gem is for you.

### This gem does the following:
1. configuring Nginx for your app by creating vhost file and restarting nginx
2. creating postgresql user with a random secure password and granting access to a database
3. creates a `.env` file for managing your app's secrets.
3. configuring puma app server with the created Nginx vhost file

---
This gem is currently under active development but can be used for deploying as of now. The pending tasks as of now is to further simplify the installation and setup process and to make this gem truly a one step deploy gem.

<strike>Documentation for using this gem will be shortly updated.</strike>
## A very brief documentation for the early adopters.
(I will get a detailed documetation in the next two days.)

### Prerequisites 
Bolt assumes that you have nginx, postgresql and ruby installed on your server. If not, you can install all these with the following command

Nginx
```
sudo apt-get install nginx
```

Postgresql
```
sudo apt-get install postgresql postgresql-develop
```

Ruby

```
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
tar -zxvf ruby-2.1.2.tar.gz
cd ruby-2.1.2/
./configure
make
sudo make install
```

Check if your postgres database has been configured for password authentication.
Open `/etc/postgresq/9.3/main/pg_hba.conf` [the value 9.3 could be different on your server based on your postgres version]

and change the following
```
# "local" is for Unix domain socket connections only
local   all             all                                     peer
```
to 
```
# "local" is for Unix domain socket connections only
local   all             all                                     md5
```

Then restart the postgres server to load the new configuration
```
sudo /etc/init.d/postgresql restart
```

Bolt requires an user on the server that can use `sudo` without password.
```
adduser deployer
echo "deployer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```

With the above setup, the server setup for Bolt is complete. If your server is already setup like above there is no need to do all these steps.

## Using Bolt

### Installing gem
in your gemfile add
```
# Gemfile
gem 'dotenv-rails'
```
as the first gem. This is a requirement for Bolt setup to work currently. In near future, this requirement will be eliminated.

then add
```
# Gemfile
gem 'puma'
gem 'capistrano-bolt', group: :development
```

and run
```
bundle install
```

### Configuring
run
```
cap install
```
and change the contents of`Capfile`, `deploy.rb` and `production.rb` file with contents as given in https://github.com/opendrops/capistrano-bolt/tree/master/lib/capistrano/templates/capistrano

This step will be automated in future. For now, just use the given templates as reference to modify the values.

If you use rbenv or rvm or chruby, be sure to add these gems in your gemfile and uncomment the require statements for these gems in `Capfile`.

### Deploying
Run the following command for the first time when you deploy the app
```
cap production setup:all
```
The above command configures your nginx, postgresql, dotenv file.

Now deploy your app using
```
cap production deploy
```

wait for the task to complete and visit the url for your app domain. You should now see your app fully deployed on your server without you having to login to the server and do many of the repetitive boring tasks.

---
**Note:** I have written this quick install document seeing that many people have tried to download this gem without any documentation. So this document is prepared in a hurry to fill this gap. If you are getting errors or if the information in this document is inadequate,  contact me @ shankar AT opendrops DOT com and I shall be able to guide you as soon as possible.

