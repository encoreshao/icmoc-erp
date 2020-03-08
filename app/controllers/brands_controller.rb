# frozen_string_literal: true

class BrandsController < BaseController
  protected

  def collection
    @brands ||= end_of_association_chain.with_name(params[:name]).page(params[:page]).per(10)
  end

  def brand_params
    params.require(:brand).permit([:name])
  end
end
