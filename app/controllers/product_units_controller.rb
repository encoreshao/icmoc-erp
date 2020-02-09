# frozen_string_literal: true

class ProductUnitsController < BaseController
  def create
    resource = ProductUnit.new(product_unit_params)

    create! { collection_path }
  end

  def update
    resource = ProductUnit.find params[:id]
    resource.update_attributes(product_unit_params)

    update! { collection_path }
  end

  protected

  def collection
    @product_units ||= end_of_association_chain.with_name(params[:name])
                                               .page(params[:page]).per(20)
  end

  def product_unit_params
    params.require(:product_unit).permit([:name])
  end
end
