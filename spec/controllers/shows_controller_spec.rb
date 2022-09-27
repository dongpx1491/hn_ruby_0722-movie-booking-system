require "rails_helper"

RSpec.describe ShowsController, type: :controller do
  let!(:movie) {FactoryBot.create :movie}
  let!(:show) {FactoryBot.create :show, movie_id: movie.id, end_time: Time.now}
  let!(:user) {FactoryBot.create :user}
  before do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
    allow(controller).to receive(:authenticate_user!).and_return true
  end
  it {should use_before_action(:find_movie)}
  describe "GET #index" do
    context "when show is present" do
      before{get :index, params: {movie_id: movie.id}}

      it "assigns the requested movie" do
        expect(assigns :shows).to eq([show])
      end

      it "renders the :show template" do
        response.should render_template("index")
      end
    end
  end

  describe "GET #show" do
    before{get :show, params: {movie_id: movie.id, id: show.id}}
    it "return show successful" do
      expect((assigns :show)).to eq show
    end
  end

  describe "when movie is not present" do
    before{get :index, params: {movie_id: 0}}

    it "show flash message" do
      expect(flash[:warning]).to eq I18n.t("shows.not_found")
    end
  end
end
