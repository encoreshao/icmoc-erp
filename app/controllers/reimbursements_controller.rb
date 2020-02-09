# frozen_string_literal: true

class ReimbursementsController < BaseController
  def all
    @reimbursements ||= end_of_association_chain
                        .includes([user: [:detail]])
                        .page(params[:page])
                        .per(10)
  end

  def create
    params[:reimbursement][:user_id] = current_user.id
    resource = Reimbursement.new(reimbursement_params)

    create! do |success, failure|
      success.html { redirect_to collection_path }
      failure.html { render :new }
    end
  end

  def edit
    params[:redirect_url] = params[:redirect_url] || request.referer

    super
  end

  def update
    resource = Reimbursement.find_by_id params[:id]
    resource.update_attributes(reimbursement_params)

    update! do |success, failure|
      success.html { redirect_to params[:redirect_url] }
      failure.html { render :edit }
    end
  end

  def confirm
    resource = Reimbursement.find_by_id params[:id]
    redirect_to request.referer if resource.confirm!
  end

  def pay
    resource = Reimbursement.find_by_id params[:id]
    redirect_to request.referer if resource.pay!
  end

  protected

  def collection
    @reimbursements ||= end_of_association_chain
                        .includes([user: [:detail]])
                        .unprocessed.with_user(current_user.id)
                        .page(params[:page])
                        .per(10)
  end

  def reimbursement_params
    params.require(:reimbursement).permit([
                                            :state,
                                            :pm_user_id,
                                            :user_id,
                                            episodes_attributes: %i[id reimbursement_id activity_date usage amount description count _destroy]
                                          ])
  end
end
