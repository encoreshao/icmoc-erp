# frozen_string_literal: true

task :restore_database do
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed:setup'].invoke
  Rake::Task['china_regions:all'].invoke
end
