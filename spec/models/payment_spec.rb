require "rails_helper"

RSpec.describe Payment, type: :model do
  describe "associations" do
    it {should have_many(:tickets).dependent(:destroy)}
    it {should belong_to(:user)}
  end

  describe "enum or status" do
    it {should define_enum_for(:status).with_values(inactive: 0, active: 1)}
  end

  describe "scope" do
    let!(:payment_1) {FactoryBot.create :payment, activated_at: "2022-08-22 08:39:57", status: :active}
    let!(:payment_2) {FactoryBot.create :payment, activated_at: "2022-08-15 09:39:57", status: :inactive}
    let!(:payment_3) {FactoryBot.create :payment, activated_at: "2022-09-02 07:39:57", status: :active}

    it "latest payment" do
      Payment.latest.pluck(:id).should eq([payment_3.id, payment_1.id, payment_2.id])
    end

    it "show_active" do
      Payment.show_active.pluck(:id).count.should eq 2
    end
  end

  describe "Payment method" do
    let(:payment){FactoryBot.create :payment}
    describe "#create activation digest" do
      it "success create activation digest" do
        expect(payment.create_activation_digest).to be_truthy
      end
    end

    describe "#payment expired" do
      it "payment isn't expired" do
        expect(payment.payment_expired?).to be_falsey
      end
    end
  end
end
