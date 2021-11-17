require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.create' do
    subject { described_class.create(attributes) }

    context 'with valid attributes' do
      include_examples 'creates_object_for', :user
    end

    context 'with invalid attributes' do
      context 'with invalid email' do
        include_examples 'not_create_object_for', :user, email: 'test'
      end

      context 'with invalid password' do
        include_examples 'not_create_object_for', :user, password: '111'
      end
    end

    context 'with missing attributes' do
      context 'when missing name' do
        include_examples 'not_create_object_for', :user, name: nil
      end

      context 'when missing surname' do
        include_examples 'not_create_object_for', :user, surname: nil
      end

      context 'when missing email' do
        include_examples 'not_create_object_for', :user, email: nil
      end

      context 'when missing password' do
        include_examples 'not_create_object_for', :user, password: nil
      end
    end
  end

  describe '.assign_admin_role' do
    subject { user.assign_admin_role }

    let!(:role) { FactoryBot.create(:role, name: 'user') }
    let!(:user) { FactoryBot.create(:user, role: role) }

    before { FactoryBot.create(:role, name: 'admin') }
    before { subject }

    it 'make user an admin' do
      expect(user.role.name).to eq('admin')
    end
  end

  describe '.assign_user_role' do
    subject { user.assign_user_role }

    let!(:role) { FactoryBot.create(:role, name: 'admin') }
    let!(:user) { FactoryBot.create(:user, role: role) }

    before { FactoryBot.create(:role, name: 'user') }
    before { subject }

    it 'make admin an user' do
      expect(user.role.name).to eq('user')
    end
  end
end
