require "rails_helper"

RSpec.describe PaymentsController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:payment) {FactoryBot.create :payment, user_id: user.id}
  let!(:ticket) {FactoryBot.create :ticket, payment_id: payment.id}
  it {should use_before_action(:load_payment)}
  it {should use_before_action(:check_expiration)}
  before do
      allow(controller).to receive(:current_user).and_return(user)
      sign_in user
      allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe "Dont have current payment" do
    before {get :show, params: {id: payment.id}}
    it "should flash error message" do
      expect(flash[:danger]).to eq I18n.t("payments.not_found")
    end

    it "redirect to root path" do
      response.should redirect_to root_path
    end
  end

  describe "payment has been expired" do
    before do
      allow(controller).to receive(:current_payment).and_return(payment)
      allow_any_instance_of(Payment).to receive(:payment_expired?).and_return true
    end
    before {get :show, params: {id: payment.id}}
    it "should flash error message" do
      expect(flash[:danger]).to eq I18n.t("payments.danger")
    end

    it "redirect to root path" do
      response.should redirect_to root_path
    end
  end

  describe "current payment is present" do
    before {allow(controller).to receive(:current_payment).and_return(payment)}

    describe "GET #show" do
      before {get :show, params: {id: payment.id}}
      it "should return the payment tickets" do
       expect(assigns :tickets).to eq([ticket])
      end
    end

    describe "GET #activation" do
      before {get :activation, params: {id: payment.id}}
      it "should flash info message" do
        expect(flash[:info]).to eq I18n.t("payments.activation.info")
      end

      it "redirect to movie show path" do
        response.should redirect_to payment_path(payment)
      end
    end

    describe "DELETE #destroy" do
      before {delete :destroy, params: {id: payment.id}}
      context "when the payment has been deleted" do
        it "should flash success message" do
          expect(flash[:success]).to eq I18n.t("payments.destroy.success")
        end

        it "reder non payment" do
          response.should render_template(:non_payment)
        end
      end
    end
  end
end
