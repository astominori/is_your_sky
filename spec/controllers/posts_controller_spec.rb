require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#show" do
    let(:user){ create(:user) }
    let(:post){ create(:post, user_id: user.id) }

    before do
      user.confirm
    end

    context "投稿したユーザとして" do
      before do
        sign_in user
      end

      it "正常にレスポンスを返すこと" do
        get :show, params: { id: post.id }
        expect(response).to be_successful
      end
    end

    context "投稿していない他のユーザとして" do
      let(:other_user){ create(:user, :other_user) }
      before do
        other_user.confirm
        sign_in other_user
      end

      it "正常にレスポンスを返すこと" do
        get :show, params: { id: post.id }
        expect(response).to be_successful
      end
    end

    context "ゲストとして" do
      it "ログイン画面にリダイレクトする" do
        get :show, params: { id: post.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    context "正しいユーザとして" do
      let(:user){ create(:user) }

      before do
        user.confirm
      end

      context "有効な値を持つ場合" do
        it "ポストを追加できること" do
          post_params = attributes_for(:post, user_id: user)
          sign_in user
          expect {
            get :create, params: { post: post_params }
          }.to change { user.posts.count }.by(1)
        end
      end

      context "無効な値を持つ場合" do
        it "ポストを追加できないこと" do
          post_params = attributes_for(:wrong_post, user_id: user)
          sign_in user
          expect {
            get :create, params: { post: post_params }
          }.to_not change(user.posts, :count)
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

  describe "#edit" do
    let(:user){ create(:user) }
    let(:post){ create(:post, user_id: user.id) }
    before do
      user.confirm
    end

    context "投稿ユーザとして" do
      it "正常なレスポンスを返す" do
        sign_in user
        get :edit, params: { id: post.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        sign_in user
        get :edit, params: { id: post.id }
        expect(response).to have_http_status(200)
      end

      it "editテンプレートを描画する" do
        sign_in user
        get :edit, params: { id: post.id }
        expect(response).to render_template(:edit)
      end
    end

    context "投稿していないユーザとして" do
      let(:other_user){ create(:user, :other_user) }
      before do
        other_user.confirm
      end

      it "マイページ画面にリダイレクトする" do
        sign_in other_user
        get :edit, params: { id: post.id }
        expect(response).to redirect_to user_root_path
      end
    end

    context "ゲストとして" do
      it "ログイン画面にリダイレクトする（devise既定）" do
        get :edit, params: { id: post.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    let(:post){ create(:post, user_id: user.id) }
    let(:user){ create(:user) }
    before do
      user.confirm
    end

    context "投稿ユーザとして" do
      it "投稿を更新できること" do
        post_params = attributes_for(
          :post,
          user_id: user.id,
          title: "change the title"
        )
        sign_in user
        get :update, params: { id: post.id, post: post_params }
        expect(post.reload.title).to eq "change the title"
      end
    end

    context "投稿していないのユーザとして" do
      let(:other_user){ create(:user, :other_user) }
      before do
        other_user.confirm
      end

      it "マイページ画面にリダイレクトされること" do
        post_params = attributes_for(
          :post,
          user_id: user.id,
          title: "change the title"
        )
        sign_in other_user
        get :update, params: { id: post.id, post: post_params }
        expect(response).to redirect_to user_root_path
      end
    end

    context "ゲストとして" do
      it "ログイン画面にリダイレクトする（devise既定）" do
        post_params = attributes_for(
          :post,
          user_id: user.id,
          title: "change the title"
        )
        get :update, params: { id: post.id, post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#todays_posts" do
    context "正しいユーザとして" do
      let(:user){ create(:user) }
      let(:posts){ create_list(:post, 5, user_id: user.id) }
      before do
        user.confirm
      end

      it "正常にレスポンスを返すこと" do
        sign_in user
        get :todays_posts
        expect(response).to be_successful
      end

      it "200レスポンスを返すこと" do
        sign_in user
        get :todays_posts
        expect(response).to have_http_status "200"
      end

      it "todays_postsが投稿を5つ保持すること" do
        sign_in user
        get :todays_posts
        expect(assigns[:todays_posts]).to eq posts
      end

      it "todays_postsのテンプレートを返すこと" do
        sign_in user
        get :todays_posts
        expect(response).to render_template("todays_posts")
      end
    end
  end
end
