require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#index" do
    context "正しいユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "304レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること（devise既定）" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    context "正しいユーザとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "ポストを追加できること" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        expect {
          get :create, params: { post: post_params }
        }.to change{@user.posts.count}.by(1)
      end
    end
  end
end
