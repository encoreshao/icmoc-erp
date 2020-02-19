# frozen_string_literal: true

class CompaniesController < BaseController
  def create
    resource = Company.new(company_params)

    create! { collection_path }
  end

  def update
    resource = Company.find params[:id]
    resource.update_attributes(company_params)

    update! { collection_path }
  end

  def destroy
    resource = Company.find params[:id]

    if !resource.users.empty?

    else
      destroy! { collection_path }
    end
  end

  protected

  def collection
    @companies ||= end_of_association_chain.page(params[:page]).per(10)
  end

  def company_params
    permit_fields = %i[
      name industry nature_of_business legal_person bank_address bank_account
      tax_no website logo telephone contact_person address fax postcode
      introduction description province_id city_id district_id
    ]

    params.require(:company).permit(permit_fields)
  end
end
