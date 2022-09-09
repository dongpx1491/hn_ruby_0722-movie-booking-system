require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe "association" do
    it { should have_many(:movies).dependent(:destroy) }
  end
  
  describe "validation" do
    context "when field title" do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(Settings.genre.name.max_length) } 
    end
  end

  describe "scope" do
    let!(:genre_1){FactoryBot.create :genre, name: "Horror"}
    let!(:genre_2){FactoryBot.create :genre, name: "Adventure"}
    let!(:genre_3){FactoryBot.create :genre, name: "Action"}

    it "order name" do
      Genre.asc_genre_name.pluck(:name).should eq([genre_3.name, genre_2.name, genre_1.name])
    end
  end
end
