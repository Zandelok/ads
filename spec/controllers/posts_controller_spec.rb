require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #show' do
    let(:post) { FactoryBot.create(:post) }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'assigns post' do
      get :show, params: { id: post.id, user_id: post.user_id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'GET #new' do
    let(:user) { FactoryBot.create(:user) }
    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'assigns a new post as @post' do
      get :new, params: { user_id: user.id }
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:post_params) { FactoryBot.attributes_for(:post, user_id: user.id) }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'creates new post' do
      post :create, params: { user_id: user.id, post: post_params }

      expect(response).to have_http_status(:ok)
    end

    it 'don`t create post' do
      post :create, params: { user_id: user.id, post: post_params.except(:title) }

      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    let(:post) { FactoryBot.create(:post) }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'assigns the requested post as @post' do
      get :edit, params: { id: post.id, user_id: post.user_id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'PUT #update' do
    let(:post) { FactoryBot.create(:post) }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'updates the requested post' do
      put :update, params: { user_id: post.user_id, id: post.id, post: { title: 'brbrbr' } }
      expect(response).to have_http_status(:found)
    end

    it 'don`t update post' do
      put :update, params: { user_id: post.user_id, id: post.id, post: { title: '' } }

      expect(response).to render_template('edit')
    end
  end

  describe 'DELETE #destroy' do
    let(:post) { FactoryBot.create(:post) }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'destroys post' do
      delete :destroy, params: { user_id: post.user_id, id: post.id }

      expect(response).to redirect_to("/users/#{post.user_id}")
    end
  end

  describe 'GET #submit_post' do
    let(:post) { FactoryBot.create(:post) }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'asks post to publish' do
      get :submit_post, params: { user_id: post.user_id, id: post.id }

      expect(response).to redirect_to("/users/#{post.user_id}/posts/#{post.id}")
    end
  end

  describe 'GET #undo_submit' do
    let(:post) { FactoryBot.create(:post, state: 'submitted') }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'undo decision to publish post' do
      get :undo_submit, params: { user_id: post.user_id, id: post.id }

      expect(response).to redirect_to("/users/#{post.user_id}/posts/#{post.id}")
    end
  end

  describe 'GET #approve_post' do
    let(:post) { FactoryBot.create(:post, state: 'submitted') }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'approves post to publish' do
      get :approve_post, params: { id: post.id }

      expect(response).to redirect_to('/admin/posts')
    end
  end

  describe 'GET #decline_post' do
    let(:post) { FactoryBot.create(:post, state: 'submitted') }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    it 'declines post to publish' do
      get :decline_post, params: { id: post.id }

      expect(response).to redirect_to('/admin/posts')
    end
  end

  describe 'GET #change_mind' do
    let(:post) { FactoryBot.create(:post, state: 'declined') }
    let(:post1) { FactoryBot.create(:post, state: 'approved') }

    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

    context 'when post declined' do
      it 'undo decision to decline post' do
        get :change_mind, params: { id: post.id }

        expect(response).to redirect_to('/admin/posts')
      end
    end

    context 'when post approved' do
      it 'undo decision to approve post' do
        get :change_mind, params: { id: post1.id }

        expect(response).to redirect_to('/admin/posts')
      end
    end
  end
end
