require "rails_helper"

RSpec.describe User, type: :model do

  describe "associations" do
    it {should have_many(:user_discounts).dependent(:destroy)}
    it {should have_many(:ratings).dependent(:destroy)}
    it {should have_many(:discounts).dependent(:destroy)}
    it {should have_many(:payments).dependent(:destroy)}
  end

  describe "enum for status" do
    it {should define_enum_for(:role).with_values(customer: 0, admin: 1)}
  end

  describe "validates" do
    context "when validate presence" do
      %i(email name phone_number password date_of_birth).each do |attr|
        it {should validate_presence_of attr}
      end
    end

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

  describe "Secure Password" do
    it {should have_secure_password}
  end

  describe "#create_activation_digest" do
    let(:user) {FactoryBot.build :user}
    it "success create activation digest" do
      expect(user).to receive(:create_activation_digest)
      user.run_callbacks(:create)
    end
  end

  describe "User methods" do
    let(:user) {FactoryBot.create :user}

    describe "#password reset expired" do
      it "password reset is expired" do
        user.create_reset_digest
        expect(user.password_reset_expired?).to be_falsey
      end
    end

    describe "#remember" do
      it "success remember token" do
        expect(user.remember).to be_truthy
      end
    end

    describe "#forget" do
      it "success forget token" do
        expect(user.forget).to be_truthy
      end
    end

    describe "#active" do
      it "success active user" do
        expect(user.activate).to be_truthy
      end
    end
  end
end
