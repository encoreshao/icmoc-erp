# frozen_string_literal: true

class ProjectsController < BaseController
  def create
    resource = Project.new(project_params)

    create! { collection_path }
  end

  def update
    resource = Project.find params[:id]
    resource.update_attributes(project_params)

    update! { collection_path }
  end

  def close; end

  def reopen; end

  protected

  def collection
    @projects ||= end_of_association_chain.includes([:manager, sale: [:company]])
                                          .page(params[:page]).per(10)
  end

  def project_params
    params.require(:project).permit(%i[name pm_user_id sale_id number budget])
  end
end
