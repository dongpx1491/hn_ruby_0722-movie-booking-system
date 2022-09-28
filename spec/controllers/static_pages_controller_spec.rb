require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  let!(:genre1){FactoryBot.create :genre, name: "JumpScare"}
  let!(:genre2){FactoryBot.create :genre, name: "Action"}
  let!(:movie_1){FactoryBot.create :movie, cast: "Cast 1", genre_id: genre1.id}
  let!(:movie_2){FactoryBot.create :movie, cast: "Cast 2", genre_id: genre1.id}
  let!(:movie_3){FactoryBot.create :movie, cast: "Cast 3", genre_id: genre2.id}

  describe "GET #home" do
    before {get :home}
    it "return true movies" do
      expect(assigns(:movies)).to eq([movie_3, movie_2, movie_1])
    end

    it "return true genres" do
      expect(assigns(:genres)).to eq([genre2, genre1])
    end
  end
end
