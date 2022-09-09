require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "association" do
    it { should have_many(:ratings).dependent(:destroy) }
    it { should have_many(:shows).dependent(:destroy) }
    it { should belong_to(:genre) }
  end

  describe "validation" do
    context "when field title" do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_most(Settings.movie.name.max_length)} 
    end
    context "when field description" do 
      it { should validate_presence_of(:description) }
      it { should validate_length_of(:description).is_at_most(Settings.movie.content.max_length)} 
    end
    [:release_date, :language, :duration, :cast, :director].each do |field|
      context "when field #{field}" do
        it { should validate_presence_of(field) }
      end
    end
  end

  describe "scope" do
    let!(:movie_1){FactoryBot.create :movie, title: "Thor", description: "Good"}
    let!(:movie_2){FactoryBot.create :movie, title: "Matrix", description: "Matrix", release_date: "2022-10-23"}
    let!(:movie_3){FactoryBot.create :movie, title: "Titanic", description: "Not so good", release_date: "2022-11-23"}

    it "release date" do
      Movie.release.pluck(:id).should eq([movie_1.id, movie_2.id, movie_3.id])
    end

    it "latest" do
      Movie.latest.pluck(:id).should eq([movie_3.id, movie_2.id, movie_1.id])
    end
    context "search_by_name_or_description" do
      it "search empty" do
        Movie.search("").pluck(:id).should eq(Movie.all.pluck(:id))
      end

      it "search content no match" do
        Movie.search("ChingChong").pluck(:id).should eq([])
      end
      it "search content match" do
        Movie.search("matr").pluck(:id).should eq([movie_2.id])
      end
    end
  end

  describe "instance method" do
    let!(:movie){FactoryBot.create :movie}

    describe "respond to its method" do
      it {should respond_to :display_image}
    end


    describe "#display_image" do
      it "returns true" do
        movie.image.attach(io: File.open("spec/fixtures/thor.jpg"), filename: "thor.jpg", content_type: "image/jpg")
        movie.display_image
      end
    end
  end
end
