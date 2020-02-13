# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  assignable  :boolean
#  builtin     :integer          default(0), not null
#  name        :string
#  permissions :text
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name)
#

class Role < ApplicationRecord
  include CommonScope

  # Custom coder for the permissions attribute that should be an
  # array of symbols. Rails 3 uses Psych which can be *unbelievably*
  # slow on some platforms (eg. mingw32).
  class PermissionsAttributeCoder
    def self.load(str)
      str.to_s.scan(/:([a-z0-9_]+)/).flatten.map(&:to_sym)
    end

    def self.dump(value)
      YAML.dump(value)
    end
  end

  # Built-in roles
  BUILTIN_NON_MEMBER = 1
  BUILTIN_ANONYMOUS  = 2

  scope :sorted, -> { order("#{table_name}.builtin ASC, #{table_name}.position ASC") }
  scope :givable, -> { order("#{table_name}.position ASC").where(builtin: 0) }
  scope :builtin, lambda { |*args|
    compare = (args.first == true ? 'not' : '')
    where("#{compare} builtin = 0")
  }

  before_destroy :check_deletable
  # acts_as_list

  serialize :permissions, ::Role::PermissionsAttributeCoder
  # attr_protected :builtin

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, maximum: 30

  # Copies attributes from another role, arg can be an id or a Role
  def copy_from(arg, _options = {})
    return unless arg.present?

    role = arg.is_a?(Role) ? arg : Role.find_by_id(arg.to_s)
    self.attributes = role.attributes.dup.except('id', 'name', 'position', 'builtin', 'permissions')
    self.permissions = role.permissions.dup
    self
  end

  def permissions=(perms)
    perms = perms.collect { |p| p.to_sym unless p.blank? }.compact.uniq if perms

    write_attribute(:permissions, perms)
  end

  def add_permission!(*perms)
    self.permissions = [] unless permissions.is_a?(Array)

    permissions_will_change!
    perms.each do |p|
      p = p.to_sym
      permissions << p unless permissions.include?(p)
    end
    save!
  end

  def remove_permission!(*perms)
    return unless permissions.is_a?(Array)

    permissions_will_change!
    perms.each { |p| permissions.delete(p.to_sym) }
    save!
  end

  # Returns true if the role has the given permission
  def has_permission?(perm)
    !permissions.nil? && permissions.include?(perm.to_sym)
  end

  def <=>(role)
    if role
      if builtin == role.builtin
        position <=> role.position
      else
        builtin <=> role.builtin
      end
    else
      -1
    end
  end

  def to_s
    name
  end

  # Return true if the role is a builtin role
  def builtin?
    builtin != 0
  end

  # Return true if the role is the anonymous role
  def anonymous?
    builtin == 2
  end

  # Return true if the role is a project member role
  def member?
    !builtin?
  end

  # Return true if role is allowed to do the specified action
  # action can be:
  # * a parameter-like Hash (eg. :controller => 'projects', :action => 'edit')
  # * a permission Symbol (eg. :edit_project)
  def allowed_to?(action)
    if action.is_a? Hash
      allowed_actions.include? "#{action[:controller]}/#{action[:action]}"
    else
      allowed_permissions.include? action
    end
  end

  # Return all the permissions that can be given to the role
  def setable_permissions
    setable_permissions = Erp::AccessControl.permissions - Erp::AccessControl.public_permissions
    setable_permissions -= Erp::AccessControl.members_only_permissions if builtin == BUILTIN_NON_MEMBER
    setable_permissions -= Erp::AccessControl.loggedin_only_permissions if builtin == BUILTIN_ANONYMOUS
    setable_permissions
  end

  # Find all the roles that can be given to a project member
  def self.find_all_givable
    Role.givable.all
  end

  # Return the builtin 'non member' role.  If the role doesn't exist,
  # it will be created on the fly.
  def self.non_member
    find_or_create_system_role(BUILTIN_NON_MEMBER, 'Non member')
  end

  # Return the builtin 'anonymous' role.  If the role doesn't exist,
  # it will be created on the fly.
  def self.anonymous
    find_or_create_system_role(BUILTIN_ANONYMOUS, 'Anonymous')
  end

  private

  def allowed_permissions
    @allowed_permissions ||= permissions + Erp::AccessControl.public_permissions.collect(&:name)
  end

  def allowed_actions
    @actions_allowed ||= allowed_permissions.inject([]) { |actions, permission| actions += Erp::AccessControl.allowed_actions(permission) }.flatten
  end

  def check_deletable
    raise "Can't delete role" if members.any?
    raise "Can't delete builtin role" if builtin?
  end

  def self.find_or_create_system_role(builtin, name)
    role = where(builtin: builtin).first
    if role.nil?
      role = create(name: name, position: 0) do |r|
        r.builtin = builtin
      end
      raise "Unable to create the #{name} role." if role.new_record?
    end
    role
  end
end
