require 'cancan/matchers'
require 'rails_helper'

describe 'User' do
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }

    context 'when there is no user' do
      let(:user) { nil }
      it { is_expected.to be_able_to(:read, Category) }
      it { is_expected.to be_able_to(:read, Post) }
      it { is_expected.to be_able_to(:read, User) }
    end

    context 'when is user' do
      let!(:role) { FactoryBot.create(:role, name: 'user') }
      let!(:user) { FactoryBot.create(:user, role: role) }
      it { is_expected.to be_able_to(:read, Category) }
      it { is_expected.to be_able_to(:read, Post) }
      it { is_expected.to be_able_to(:read, User) }
      it { is_expected.to be_able_to(%i[read create update destroy submit_post undo_submit], Post.new(user_id: user.id)) }
      it { is_expected.to be_able_to(%i[read update destroy], User.new(id: user.id)) }
    end

    context 'when is admin' do
      let!(:role) { FactoryBot.create(:role, name: 'admin') }
      let!(:user) { FactoryBot.create(:user, role: role) }
      it { is_expected.to be_able_to(:manage, Category) }
      it { is_expected.to be_able_to(:manage, Role) }
      it { is_expected.to be_able_to(:read, ActiveAdmin::Page) }
      it { is_expected.to be_able_to(%i[read destroy make_admin make_user], User) }
      it { is_expected.to be_able_to(%i[read destroy approve_post decline_post change_mind], Post) }
      it { is_expected.to be_able_to(:manage, User.new(id: user.id)) }
    end
  end
end
