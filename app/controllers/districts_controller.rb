# frozen_string_literal: true

class DistrictsController < BaseController
  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  protected

  def collection
    @collection ||= end_of_association_chain.includes([city: [:province]]).with_name(params[:name]).for_city(params[:city_id])
                                            .page(params[:page]).per(10)
  end
end
