# frozen_string_literal: true

module Erp
  module Info
    class << self
      def app_name
        'ERP'
      end

      def url
        "http://#{APP_CONFIG['domain']}"
      end

      def versioned_name
        "#{app_name} #{Erp::VERSION.revision}"
      end
    end
  end
end
