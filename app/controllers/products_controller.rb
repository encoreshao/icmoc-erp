# frozen_string_literal: true

class ProductsController < BaseController
  protected

  def collection
    @products ||= end_of_association_chain.with_name(params[:name])
                                          .includes(%i[brand product_unit])
                                          .page(params[:page]).per(10)
  end

  def product_params
    params.require(:product).permit(%i[name model brand_id product_unit_id])
  end
end
