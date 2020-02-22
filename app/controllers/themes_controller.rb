# frozen_string_literal: true

class ThemesController < BaseController
  def create
    create! { collection_path }
  end

  def update
    update! { collection_path }
  end

  protected

  def collection
    @collection ||= begin
      end_of_association_chain.page(params[:page]).per(5)
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :image, :position)
  end
end
