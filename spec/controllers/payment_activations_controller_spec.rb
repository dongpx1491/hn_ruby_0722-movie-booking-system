require "rails_helper"

RSpec.describe PaymentActivationsController, type: :controller do
  it {should use_before_action(:load_payment)}
  describe "GET #edit" do
    describe "payments is present" do
      context "when payment is inactive" do
        let!(:payment) {FactoryBot.create :payment, status: :inactive}
        before {allow_any_instance_of(Payment).to receive(:authenticated?).with("abc").and_return(true)}
        before do
          get :edit, params: {id: "abc", payment_id: payment.id}
        end

        it "show success flash message" do
          expect(flash[:success]).to eq I18n.t("payment_activations.edit.success")
        end
      end

      context "payment is active" do
        let!(:payment) {FactoryBot.create :payment, status: :active}
        before do
          get :edit, params: {id: "abc", payment_id: payment.id}
        end
        it "show danger flash message" do
          expect(flash[:danger]).to eq I18n.t("payment_activations.edit.danger")
        end
        it "redirect to root_path" do
          response.should redirect_to(root_path)
        end
      end
    end

    describe "when payment is not present" do
      before do
        get :edit, params: {id: "abc", payment_id: 0}
      end

      it "show danger flash message" do
        expect(flash[:danger]).to eq I18n.t("payment_activations.not_found")
      end

      it "redirect to root_path" do
        response.should redirect_to(root_path)
      end
    end
  end
end
