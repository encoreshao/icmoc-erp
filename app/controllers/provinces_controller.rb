# frozen_string_literal: true

class ProvincesController < BaseController
  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  protected

  def collection
    @collection ||= end_of_association_chain.with_name(params[:name])
                                            .page(params[:page]).per(10)
  end
end
