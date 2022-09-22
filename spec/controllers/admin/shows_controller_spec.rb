require "rails_helper"

RSpec.describe Admin::ShowsController, type: :controller do
  let!(:admin){FactoryBot.create :user, role: 1}

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "returns a 302 response" do
      get :index
      expect(response).to have_http_status "302"
    end
  end

  # describe "GET #new" do
  #   it "should render template new" do
  #     get :new
  #     expect(response).to redirect_to :admin_genres
  #   end
  # end

  # describe "GET #edit" do
  #   context "when success" do
  #     before do
  #       get :edit, xhr: true, params: {id: book_1.id}
  #     end

  #     it "should render template new" do
  #       expect(response).to render_template :edit
  #     end
  #     it "should data book 1" do
  #       expect(assigns(:book)).to eq book_1
  #     end
  #   end

  #   context "when failure" do
  #     before do
  #       get :edit, xhr: true, params: {id: -1}
  #     end

  #     it "should flash not found" do
  #       expect(flash[:warning]).to eq I18n.t("admin.books.edit.not_found")
  #     end
  #     it "should redirect to root_path" do
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  # end
end