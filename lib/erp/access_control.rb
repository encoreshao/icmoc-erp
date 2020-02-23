# frozen_string_literal: true

module Erp
  module AccessControl
    class << self
      def map
        mapper = Mapper.new
        yield mapper
        @permissions ||= []
        @permissions += mapper.mapped_permissions
      end

      attr_reader :permissions

      # Returns the permission of given name or nil if it wasn't found
      # Argument should be a symbol
      def permission(name)
        permissions.detect { |p| p.name == name }
      end

      # Returns the actions that are allowed by the permission of given name
      def allowed_actions(permission_name)
        perm = permission(permission_name)
        perm ? perm.actions : []
      end

      def public_permissions
        @public_permissions ||= @permissions.select(&:public?)
      end

      def members_only_permissions
        @members_only_permissions ||= @permissions.select(&:require_member?)
      end

      def loggedin_only_permissions
        @loggedin_only_permissions ||= @permissions.select(&:require_loggedin?)
      end

      def finances_permissions
        @finances_permissions ||= @permissions.select(&:finance?)
      end

      def project_permissions
        @project_permissions ||= @permissions.select(&:project?)
      end

      def read_action?(action)
        if action.is_a?(Symbol)
          perm = permission(action)
          !perm.nil? && perm.read?
        else
          s = "#{action[:controller]}/#{action[:action]}"
          permissions.detect { |p| p.actions.include?(s) && p.read? }.present?
        end
      end

      def available_project_modules
        @available_project_modules ||= @permissions.collect(&:project_module).uniq.compact
      end

      def modules_permissions(modules)
        @permissions.select { |p| p.project_module.nil? || modules.include?(p.project_module.to_s) }
      end
    end

    class Mapper
      def initialize
        @project_module = nil
      end

      def permission(name, hash, options = {})
        @permissions ||= []
        options[:project_module] = @project_module
        @permissions << Permission.new(name, hash, options)
      end

      def project_module(name, _options = {})
        @project_module = name
        yield self
        @project_module = nil
      end

      def mapped_permissions
        @permissions
      end
    end

    class Permission
      attr_reader :name, :actions, :project_module

      def initialize(name, hash, options)
        @name = name
        @actions = []
        @public = options[:public] || false
        @require = options[:require]
        @read = options[:read] || false
        @project_module = options[:project_module]
        hash.each do |controller, actions|
          @actions << if actions.is_a? Array
                        actions.collect { |action| "#{controller}/#{action}" }
                      else
                        "#{controller}/#{actions}"
                      end
        end
        @actions.flatten!
      end

      def public?
        @public
      end

      def require_member?
        @require && @require == :member
      end

      def require_loggedin?
        @require && (@require == :member || @require == :loggedin)
      end

      def read?
        @read
      end

      def finance?
        @require && @require == :finance
      end

      def project?
        @require && @require == :project
      end
    end
  end
end
