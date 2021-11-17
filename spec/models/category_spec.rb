require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '.create' do
    subject { described_class.create(attributes) }

    context 'with valid attributes' do
      include_examples 'creates_object_for', :category
    end

    context 'with missing attributes' do
      context 'when missing name' do
        include_examples 'not_create_object_for', :category, name: nil
      end
    end
  end
end
