require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    it 'renders index template' do
      get :index

      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    let(:category) { FactoryBot.create(:category) }

    it 'assigns category' do
      get :show, params: { id: category.id }, format: :html

      expect(assigns(:category)).to eq(category)
    end
  end
end
