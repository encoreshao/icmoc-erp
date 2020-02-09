# frozen_string_literal: true

namespace :erp do
  desc 'List all permissions and the actions registered with them'
  task permissions: :environment do
    puts 'Permission Name - controller/action pairs'
    Erp::AccessControl.permissions.sort { |a, b| a.name.to_s <=> b.name.to_s }.each do |permission|
      puts ":#{permission.name} - #{permission.actions.join(', ')}"
    end
  end
end
