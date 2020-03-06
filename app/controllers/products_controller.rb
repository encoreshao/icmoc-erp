# frozen_string_literal: true

class ProductsController < BaseController
  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  protected

  def collection
    @products ||= end_of_association_chain.with_name(params[:name])
                                          .includes(%i[brand product_unit])
                                          .page(params[:page]).per(10)
  end
end
