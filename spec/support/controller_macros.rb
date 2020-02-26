# frozen_string_literal: true

module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryBot.create(:user)

      allow_any_instance_of(described_class).to receive(:authorize).and_return(true)
    end
  end
end
