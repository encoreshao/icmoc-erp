# frozen_string_literal: true

require 'database_cleaner'

p '> clean database...'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

p '> clean up uploads...'
Dir.glob(Rails.root.join('public', 'uploads', '**')).each { |dir| FileUtils.rm_rf(dir) }
