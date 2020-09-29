require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#index" do
    context "正しいユーザーとして" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @user = create(:user)
        @user.confirm
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

  describe "#show" do
    before do
      @user = create(:user)
      @user.confirm
      @post = create(:post, user_id: @user.id)
    end

    context "投稿したユーザとして" do
      before do
        sign_in @user
      end

      it "正常にレスポンスを返すこと" do
        get :show, params: { id: @post.id }
        expect(response).to be_successful
      end
    end

    context "投稿していない他のユーザとして" do
      before do
        @other_user = create(:user, :other_user)
        @other_user.confirm
        sign_in @other_user
      end

      it "正常にレスポンスを返すこと" do
        get :show, params: { id: @post.id }
        expect(response).to be_successful
      end
    end

    context "ゲストとして" do
      it "ログイン画面にリダイレクトする" do
        get :show, params: { id: @post.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    context "正しいユーザとして" do
      before do
        @user = create(:user)
        @user.confirm
      end

      context "有効な値を持つ場合" do
        it "ポストを追加できること" do
          post_params = attributes_for(:post, user_id: @user)
          sign_in @user
          expect {
            get :create, params: { post: post_params }
          }.to change{@user.posts.count}.by(1)
        end
      end

      context "無効な値を持つ場合" do
        it "ポストを追加できないこと" do
          post_params = attributes_for(:wrong_post, user_id: @user)
          sign_in @user
          expect {
            get :create, params: { post: post_params }
          }.to_not change(@user.posts, :count)
        end
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返すこと" do
        post_params = attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    before do
      @user = create(:user)
      @user.confirm
    end
    context "投稿ユーザとして" do
      before do
        @post = create(:post, user_id: @user.id)
      end

      it "投稿を更新できること" do
        post_params = attributes_for(:post,
          user_id: @user.id,
          title: "change the title")
        sign_in @user
        get :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.title).to eq "change the title"
      end
    end

    context "その他のユーザとして" do
      before do
        @post = create(:post,
          title: "no change",
          user_id: @user.id)
        @other_user = create(:user, :other_user)
        @other_user.confirm
      end

      it "投稿が更新できないこと" do
        #やり方を探しておくこと
      end
    end
  end

  describe "#todays_posts" do
    context "正しいユーザとして" do
      before do
        @user = create(:user)
        @posts = create_list(:post, 5, user_id: @user.id)
        @user.confirm
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :todays_posts
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in @user
        get :todays_posts
        expect(response).to have_http_status "200"
      end

      it "todays_postsが投稿を5つ保持すること" do
        sign_in @user
        get :todays_posts
        expect(assigns[:todays_posts]).to eq @posts
      end

      it "todays_postsのテンプレートを返すこと" do
        sign_in @user
        get :todays_posts
        expect(response).to render_template("todays_posts")
      end
    end
  end
end
