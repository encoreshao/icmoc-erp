# frozen_string_literal: true

class BrandsController < BaseController
  def create
    resource = Brand.new(brand_params)

    create! { collection_path }
  end

  def update
    resource = Brand.find params[:id]
    resource.update_attributes(brand_params)

    update! { collection_path }
  end

  protected

  def collection
    @brands ||= end_of_association_chain.with_name(params[:name]).page(params[:page]).per(10)
  end

  def brand_params
    params.require(:brand).permit([:name])
  end
end
