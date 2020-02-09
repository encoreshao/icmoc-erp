# frozen_string_literal: true

class SettingsController < BaseController
  def create
    params[:setting][:created_by] = current_user.id
    params[:setting][:last_modified_by] = current_user.id
    resource = Setting.new(setting_params)

    create! { collection_path }
  end

  def update
    params[:setting][:last_modified_by] = current_user.id

    resource = Setting.find params[:id]
    resource.update_attributes(setting_params)

    update! { collection_path }
  end

  def destroy
    resource = Setting.find params[:id]

    destroy! { collection_path }
  end

  protected

  def collection
    @settings ||= end_of_association_chain.page(params[:page]).per(10)
  end

  def setting_params
    params.require(:setting).permit(%i[depot_alarm_value project_payment_mode purchase_payment_mode created_by last_modified_by])
  end
end
