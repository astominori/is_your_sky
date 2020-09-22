require 'rails_helper'

RSpec.describe MypagesController, type: :controller do
  describe "#show" do
    context "正しいユーザとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :show
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in @user
        get :show
        expect(response).to have_http_status "200"
      end

      it "indexテンプレートを表示すること" do
        sign_in @user
        get :show
        expect(response).to render_template(:show)
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返すこと" do
        get :show
        expect(response).to have_http_status "302"
      end

      it "ログイン画面にリダイレクトすること（devise既定）" do
        get :show
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
