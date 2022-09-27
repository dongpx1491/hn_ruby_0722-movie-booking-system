require "rails_helper"

RSpec.describe RatingsController, type: :controller do
  let!(:movie) {FactoryBot.create :movie}
  let!(:user) {FactoryBot.create :user}
  let!(:rating) {FactoryBot.create :rating, user_id: user.id, movie_id: movie.id, comment: "this is comment"}
  it {should use_before_action(:find_movie)}
  before do
      allow(controller).to receive(:current_user).and_return(user)
      sign_in user
      allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe "POST #create" do
    context "when movie is present" do
      before{post :create, xhr: true, params: {id: movie.id, rating: {comment: "this is comment"}}}
      it "respond to js" do
        expect(response).to be_successful
      end
    end

    context "when movie is not present" do
      before {post :create, format: :js, params: {movie_id: 0, rating: {comment: "this is comment"}}}

      it "show flash message" do
        expect(flash[:warning]).to eq I18n.t("not_found")
      end

      it "redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
