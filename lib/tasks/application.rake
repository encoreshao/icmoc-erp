# frozen_string_literal: true

# encofing: utf-8
#
namespace :db do
  namespace :seed do
    desc 'recreates the development database from migration, and updates the db schema if necessary'
    task setup: :environment do
      require File.dirname(__FILE__) + '/../../db/seeds_for_dev' unless Rails.env.test?
    end
  end
end
