# frozen_string_literal: true

class ProvincesController < BaseController
  def create
    resource = Province.new(province_params)

    create! { collection_path }
  end

  def update
    resource = Province.find params[:id]
    resource.update_attributes(province_params)

    update! { collection_path }
  end

  protected

  def collection
    @provinces ||= end_of_association_chain.with_name(params[:name])
                                           .page(params[:page]).per(10)
  end

  def province_params
    params.require(:province).permit(%i[name code name_en name_abbr])
  end
end
