# frozen_string_literal: true

class UsersController < BaseController
  def profile
    if request.post?
      current_user.update_attributes(user_params)

      redirect_to request.referer, notice: '用户信息更新成功!' if current_user.save
    end
  end

  def create
    resource = User.new(user_params)

    create!(notice: "用户(#{resource.detail.try(:name)})创建成功!") { collection_path }
  end

  def update
    resource = User.find params[:id]
    resource.update_attributes(user_params)

    update!(notice: '用户信息更新成功!') { request.referer }
  end

  def disable
    resource = User.find params[:id]

    if resource.update_attribute(:active, (params[:enable] == true))
      redirect_to collection_path
    end
  end

  protected

  def collection
    @users ||= end_of_association_chain.includes([:roles])
                                       .with_name(params[:name])
                                       .page(params[:page])
                                       .per(8)
  end

  def user_params
    params.require(:user).permit([:email, :password, :subject,
                                  role_ids: [],
                                  detail_attributes: %i[id name avatar hiredate address mobile_phone gender position age birthday marriage country birthplace nationality id_card_no contact_person contact_phone]])
  end
end
