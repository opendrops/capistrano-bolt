# Heroku-like easy deployment for Rails 4 with Capistrano 3, Puma, Nginx and Postgresql.

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

---

If you are like me and want a simple deployment process like above then this gem is for you.

### This gem does the following:
1. configuring Nginx for your app by creating vhost file and restarting nginx
2. creating postgresql user with a random secure password and granting access to a database
3. creates a `.env` file for managing your app's secrets.
3. configuring puma app server with the created Nginx vhost file

---
Documentation for using this gem will be shortly updated.

