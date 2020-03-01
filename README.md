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
