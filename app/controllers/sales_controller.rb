# frozen_string_literal: true

class SalesController < BaseController
  def create
    resource = Sale.new(sale_params)

    create! { collection_path }
  end

  def update
    resource = Sale.find params[:id]
    resource.update_attributes(sale_params)

    update! { collection_path }
  end

  protected

  def collection
    @sales ||= end_of_association_chain.includes(%i[owner company])
                                       .page(params[:page])
  end

  def sale_params
    params.require(:sale).permit(%i[name company_id type_name owner_id contact_no payment_mode money tax number unit freight_charge state delivery_place delivery_time delivery_content])
  end
end
