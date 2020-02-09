# frozen_string_literal: true

class DistrictsController < BaseController
  def create
    resource = District.new(districts_params)

    create! { collection_path }
  end

  def update
    resource = District.find params[:id]
    resource.update_attributes(districts_params)

    update! { collection_path }
  end

  protected

  def collection
    @districts ||= end_of_association_chain.with_name(params[:name])
                                           .page(params[:page]).per(10)
  end

  def districts_params
    params.require(:district).permit(%i[name code name_en name_abbr])
  end
end
