# frozen_string_literal: true

class CitiesController < BaseController
  def create
    resource = City.new(city_params)

    create! { collection_path }
  end

  def update
    resource = City.find params[:id]
    resource.update_attributes(city_params)

    update! { collection_path }
  end

  protected

  def collection
    @cities ||= end_of_association_chain.with_name(params[:name])
                                        .page(params[:page]).per(10)
  end

  def city_params
    params.require(:city).permit(%i[name code name_en name_abbr])
  end
end
