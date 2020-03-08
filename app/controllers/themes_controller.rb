# frozen_string_literal: true

class ThemesController < BaseController
  protected

  def collection
    @collection ||= begin
      end_of_association_chain.page(params[:page]).per(5)
    end
  end

  def theme_params
    params.require(:theme).permit(:name, :image, :position)
  end
end
