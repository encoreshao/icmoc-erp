# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BrandsController, type: :controller do
  login_user

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET edit' do
    it 'returns http success' do
      get :edit, params: { id: create(:brand) }
      expect(response).to have_http_status(:success)
    end
  end
end
