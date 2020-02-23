# frozen_string_literal: true

class UsersController < BaseController
  def profile
    if request.post?
      current_user.update_attributes(user_params)

      redirect_to request.referer, notice: t('notice_account_updated') if current_user.save
    end
  end

  def create
    create!(notice: t('notice_account_created')) { collection_path }
  end

  def update
    resource = User.find params[:id]
    resource.update_attributes(user_params)

    update!(notice: t('notice_account_updated')) { request.referer }
  end

  def disable
    resource = User.find params[:id]

    if resource.update_attribute(:active, (params[:enable] == true))
      redirect_to collection_path
    end
  end

  protected

  def collection
    @users ||= end_of_association_chain.includes(%i[detail roles])
                                       .with_name(params[:name])
                                       .page(params[:page])
                                       .per(8)
  end

  def user_params
    params.require(:user).permit([:email, :password, :subject,
                                  role_ids: [],
                                  detail_attributes: %i[
                                    id name avatar hiredate address mobile_phone gender position age
                                    birthday marriage country birthplace nationality id_card_no
                                    contact_person contact_phone theme_id locale
                                  ]])
  end
end
