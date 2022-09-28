require "rails_helper"

RSpec.describe FavoritesController, type: :controller do

  let!(:user) {FactoryBot.create :user}
  let!(:movie) {FactoryBot.create :movie}
  let!(:favorites) {FactoryBot.create :favorite, user_id: user.id, movie_id: movie.id}
  before do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
    allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe "GET #index" do
    before {get :index}
    it "return true movies" do
      expect(assigns(:movies)).to eq([movie])
    end
    it {should render_template("index")}
  end

  describe "GET #create" do
    before{post :create, format: :js, params: {id: movie.id}}
    it "respond to show" do
      expect(response).to be_successful
    end
  end

  describe "DELETE #destroy" do
    context "when the favorite is present" do
      before{delete :destroy, format: :js, params: {id: favorites.id}}
      it "destroy the favorite" do
        expect(assigns(:favorites)).to be_nil
      end
      it "respond to js" do
        expect(response).to be_successful
      end
    end

    context "when the favorite is not present" do
      before{delete :destroy, format: :js, params: {id: 0, movie_id: movie.id}}
      it "redirect to movie path" do
        expect(response).to redirect_to movie_path(movie)
      end
    end
  end
end
