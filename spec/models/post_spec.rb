require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '.create' do
    subject { described_class.create(attributes) }

    context 'with valid attributes' do
      include_examples 'creates_object_for', :post
    end

    context 'with missing attributes' do
      context 'when missing category' do
        include_examples 'not_create_object_for', :post, category_id: nil
      end

      context 'when missing user' do
        include_examples 'not_create_object_for', :post, user_id: nil
      end

      context 'when missing title' do
        include_examples 'not_create_object_for', :post, title: nil
      end

      context 'when missing text' do
        include_examples 'not_create_object_for', :post, text: nil
      end
    end
  end

  describe 'state transitions' do
    let(:post) { Post.new }

    it 'has default state' do
      expect(post).to transition_from(:draft).to(:submitted).on_event(:submit)
    end

    context 'when submitted state' do
      it 'return state to default' do
        expect(post).to transition_from(:submitted).to(:draft).on_event(:undo)
      end

      it 'move from submitted to approved' do
        expect(post).to transition_from(:submitted).to(:approved).on_event(:approve)
      end

      it 'move from submitted to declined' do
        expect(post).to transition_from(:submitted).to(:declined).on_event(:decline)
      end
    end

    context 'when declined state' do
      it 'return state to submitted' do
        expect(post).to transition_from(:declined).to(:submitted).on_event(:change)
      end

      it 'move from declined to archived' do
        expect(post).to transition_from(:declined).to(:archived).on_event(:archive)
      end
    end

    context 'when approved state' do
      it 'return state to submitted' do
        expect(post).to transition_from(:approved).to(:submitted).on_event(:change)
      end

      it 'move from approved to published' do
        expect(post).to transition_from(:approved).to(:published).on_event(:publish)
      end
    end

    it 'move from published to archived' do
      expect(post).to transition_from(:published).to(:archived).on_event(:archive)
    end
  end

  describe '.publish_post' do
    subject { post.publish_post }

    let(:post) { FactoryBot.create(:post, state: 'approved') }

    before { subject }

    it 'move state to published' do
      expect(post.reload.state).to eq('published')
    end
  end

  describe '.archive_post' do
    context 'when published state' do
      subject { post.archive_post }

      let(:post) { FactoryBot.create(:post, state: 'published') }

      before { subject }

      it 'move state from published to archived' do
        expect(post.state).to eq('archived')
      end
    end

    context 'when declined state' do
      subject { post.archive_post }

      let(:post) { FactoryBot.create(:post, state: 'declined') }

      before { subject }

      it 'move state from declined to archived' do
        expect(post.state).to eq('archived')
      end
    end
  end
end
