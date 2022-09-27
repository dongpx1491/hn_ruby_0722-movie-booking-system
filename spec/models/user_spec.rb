require "rails_helper"

RSpec.describe User, type: :model do

  describe "associations" do
    it {should have_many(:user_discounts).dependent(:destroy)}
    it {should have_many(:ratings).dependent(:destroy)}
    it {should have_many(:discounts).dependent(:destroy)}
    it {should have_many(:payments).dependent(:destroy)}
    it {should have_many(:favorites).dependent(:destroy)}
    it {should have_many(:movies).through(:favorites)}
  end

  describe "enum for status" do
    it {should define_enum_for(:role).with_values(customer: 0, admin: 1)}
  end

  describe "validates" do

    context "when length of name" do
      it {should validate_length_of(:name).is_at_most(Settings.user.name.max_length)}
    end
    context "when length of password" do
      it {should validate_length_of(:password).is_at_least(Settings.user.password.min_length)}
    end
    context "when length of phone" do
      it {should validate_length_of(:phone_number).is_equal_to(Settings.user.phone_number.length)}
    end

    context "when validate unique of email" do
      let!(:user_email1) {FactoryBot.create :user, email: "uSer1@gmail.com"}
      let!(:user_email2) {FactoryBot.build :user, email: "uSer1@gmail.com"}
      it {expect(user_email2.valid?).to eq false}
    end

    context "when email format" do
      it {should allow_value("abcde@gmail.com").for(:email)}
    end

    context "when email wrong format" do
      it {should_not allow_value("asdasdsa").for(:email)}
    end
  end

  describe "downcase email" do
    let!(:user_email) {FactoryBot.create :user, email: "USER@gmail.com"}
    it "check before save downcase email" do
      expect(user_email.email).to eq("user@gmail.com")
    end
  end
end
