# frozen_string_literal: true

class CitiesController < BaseController
  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  protected

  def collection
    @collection ||= begin
      end_of_association_chain.page(params[:page]).for_province(params[:province_id]).per(10)
    end
  end
end
