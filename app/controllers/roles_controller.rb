# frozen_string_literal: true

class RolesController < BaseController
  def new
    # Prefills the form with 'Non member' role permissions by default
    @role = Role.new(params[:role] || { permissions: Role.non_member.permissions })
    if params[:copy].present? && @copy_from = Role.find_by_id(params[:copy])
      @role.copy_from(@copy_from)
    end
    @roles = Role.sorted.all
  end

  def create
    resource = Role.new(role_params)

    create! do |success, failure|
      success.html { redirect_to collection_path }
      failure.html { render :new }
    end
  end

  def update
    resource = Role.find_by_id params[:id]

    updated_role_params = role_params
    updated_role_params['permissions'] = [] if updated_role_params['permissions'].nil?

    if resource.update_attributes(updated_role_params)
      redirect_to collection_path
    else
      render :edit
    end
  end

  def destroy
    resource = Role.find params[:id]

    if !resource.users.empty?
    else
      destroy! { collection_path }
    end
  end

  protected

  def collection
    @roles ||= end_of_association_chain.with_name(params[:name])
                                       .givable.sorted
                                       .page(params[:page]).per(50)
  end

  def role_params
    params.require(:role).permit([:name, :position, :assignable, :builtin, permissions: []])
  end
end
