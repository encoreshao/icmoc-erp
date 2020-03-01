# ICMOC ERP

A simple ERP build by Ruby on Rails

## Project requirements

  - Ruby 2.6.5
  - Rails 5.2.4
  - PostgreSQL 11

## How to set up a project locally

```
bundle exec bundle
bundle exec rake restore_database --trace

on PROD

bundle exec rake RAILS_ENV=production restore_database DISABLE_DATABASE_ENVIRONMENT_CHECK=1  --trace
```

### Errors from deployment

- Deploying a Rails App on Ubuntu 14.04 with Capistrano, Nginx, and Puma
    - https://www.digitalocean.com/community/tutorials/deploying-a-rails-app-on-ubuntu-14-04-with-capistrano-nginx-and-puma
- Bootsnap::LoadPathCache::FallbackScan
    - https://github.com/Shopify/bootsnap/issues/250
- LoadError: Could not load the 'listen' gem (Rails 5)
    - https://stackoverflow.com/questions/38663706/loaderror-could-not-load-the-listen-gem-rails-5
- ActiveSupport::MessageEncryptor::InvalidMessage Rails 5.1 secrets
    - https://github.com/rails/rails/issues/31397

```
bundle config --delete without
```
