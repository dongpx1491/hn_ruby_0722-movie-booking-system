require "rails_helper"

RSpec.describe MoviesController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  before do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
    allow(controller).to receive(:authenticate_user!).and_return true
  end
  
  describe "GET #show" do
    let!(:movie) {FactoryBot.create :movie}

    it {should use_before_action(:find_movie)}

    context "when movie is present" do
      before{get :show, params: {id: movie}}

      it "assigns the requested movie" do
        expect(assigns :movie).to eq movie
      end

      it "renders the :show template" do
        expect(response).to be_successful
      end
    end
    context "when movie is not present" do
      before{get :show, params: {id: 0}}

      it "show flash message" do
        expect(flash[:warning]).to eq I18n.t("not_found")
      end
    end
  end

  describe "GET #sort" do
    let!(:movie1) {FactoryBot.create :movie, status: :inactive}
    let!(:movie2) {FactoryBot.create :movie, status: :active}
    let!(:movie3) {FactoryBot.create :movie, status: :active}
    let!(:movie4) {FactoryBot.create :movie, status: :inactive}
    let!(:movie5) {FactoryBot.create :movie, status: :inactive}
    context "when has no sort params" do
      before{get :sort, format: :js}

      it "assigns movies" do
        expect(assigns(:movies).count).to eq 5
      end
    end

    context "when has sort params" do
      before{get :sort, format: :js, params: {m: {status_eq: 0}}}

      it "assigns movies" do
        expect(assigns(:movies)).to eq([movie5, movie4, movie1])
      end
    end

    it "render the sort" do
     expect(response).to be_successful
    end
  end
end
