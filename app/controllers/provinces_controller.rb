# frozen_string_literal: true

class ProvincesController < BaseController
  protected

  def collection
    @collection ||= end_of_association_chain.with_name(params[:name])
                                            .page(params[:page]).per(10)
  end
end
