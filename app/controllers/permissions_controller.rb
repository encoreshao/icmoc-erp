# frozen_string_literal: true

class PermissionsController < BaseController
  def update
    resource = Permission.find params[:id]
    resource.update_attributes(permissions_params)

    update! { collection_path }
  end

  def edit
    @role = Role.find params[:id]
  end

  protected

  def collection
    @permissions ||= Role.with_name(params[:name]).page(params[:page]).per(10)
  end

  def permissions_params
    params.require(:role).permit([:name])
  end
end
