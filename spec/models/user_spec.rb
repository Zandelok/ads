# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  description            :string
#  email                  :string           not null
#  encrypted_password     :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer
#  surname                :string           not null
#  role_id                :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
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
