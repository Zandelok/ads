# == Schema Information
#
# Table name: roles
#
#  id   :bigint           not null, primary key
#  name :string           not null
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  describe '.create' do
    subject { described_class.create(attributes) }

    context 'with valid attributes' do
      include_examples 'creates_object_for', :role
    end

    context 'with missing attributes' do
      context 'when missing name' do
        include_examples 'not_create_object_for', :role, name: nil
      end
    end
  end
end
