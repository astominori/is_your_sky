require 'rails_helper'

RSpec.describe MypagesController, type: :controller do
  describe "#show" do
    let(:user){ create(:user) }
    let(:other_user){ create(:user, :other_user) }
    let(:other_post){ create(:post, user_id: other_user.id) }

    before do
      user.confirm
      other_user.confirm
    end

    context "投稿０の正しいユーザとして" do
      before do
        sign_in user
        get :show
      end

      it "正常にレスポンスを返すこと" do
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        expect(response).to have_http_status "200"
      end

      it "showテンプレートを表示すること" do
        expect(response).to render_template(:show)
      end

      it "ユーザの投稿した情報が１つもないこと" do
        expect(assigns[:user_posts].size).to eq 0
      end

      it "ユーザ以外が投稿した情報が取得できる" do
        other_post.updated_at.to_date
        date = { date: other_post }
        expect(assigns[:posts_by_date]).to include { date }
      end
    end

    context "投稿済みの正しいユーザとして" do
      let(:user_post){ create(:post, user_id: user.id) }
      before do
        sign_in user
        get :show
      end

      it "user_postsでユーザが投稿した情報が取得できる" do
        expect(assigns(:user_posts)).to include user_post
      end

      it "user_postsでユーザ以外が投稿した情報は取得できない" do
        expect(assigns(:user_posts)).to_not include other_post
      end

      it "posts_by_dateでユーザ以外が投稿した情報が取得できる" do
        other_post.updated_at.to_date
        date = { date: other_post }
        expect(assigns[:posts_by_date]).to include { date }
      end

      it "posts_by_dateでユーザが投稿していない情報は取得できない" do
        other_post.updated_at.to_date
        date = { date: other_post }
        expect(assigns[:posts_by_date]).to_not include { date }
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
