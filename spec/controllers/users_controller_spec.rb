require 'rails_helper'
require_relative '../support/devise'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    login_user
    let(:cur_user) { subject.current_user }
    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'assigns user' do
      get :show, params: { id: cur_user.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    login_user
    let(:cur_user) { subject.current_user }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'delete user' do
      delete :destroy, params: { id: cur_user.id }
      expect(response).to redirect_to('/users/sign_in')
    end
  end

  describe 'GET #make_admin' do
    login_user
    let(:cur_user) { subject.current_user }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }
    before { FactoryBot.create(:role, name: 'admin') }

    it 'makes user an admin' do
      get :make_admin, params: { id: cur_user.id }
      expect(response).to redirect_to('/admin/users')
    end
  end

  describe 'GET #make_user' do
    login_user
    let(:cur_user) { subject.current_user }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }
    before { FactoryBot.create(:role, name: 'user') }

    it 'makes admin an user' do
      get :make_user, params: { id: cur_user.id }
      expect(response).to redirect_to('/admin/users')
    end
  end
end
