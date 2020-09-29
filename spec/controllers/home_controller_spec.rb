require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "正常にレスポンスを返すこと" do
      get :index
      expect(response).to be_successful
    end

    it "200レスポンスを返すこと" do
      get :index
      expect(response).to have_http_status "200"
    end

    it "indexテンプレートを返すこと" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#about" do
    it "正常にレスポンスを返すこと" do
      get :about
      expect(response).to be_successful
    end

    it "200レスポンスを返すこと" do
      get :about
      expect(response).to have_http_status "200"
    end

    it "aboutテンプレートを返すこと" do
      get :about
      expect(response).to render_template(:about)
    end
  end
end
