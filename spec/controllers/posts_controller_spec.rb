require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #new" do
    before { get :new }

    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end

    it '新しいpostオブジェクトがビューに渡されること' do
      expect(assigns(:post)).to be_a_new Post
    end
  end

end
