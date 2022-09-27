require "rails_helper"

RSpec.describe OrderHistorysController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  before do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
    allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe "GET #index" do
    context "when user have payment" do
      let!(:payment) {FactoryBot.create(:payment, status: :active, user_id: user.id)}
      before do
        get :index
      end
      it "assigns payment" do
        expect(assigns :payments).to eq([payment])
      end
    end
    context "when user dont have payment" do
      before {get :index}
      it "show flash message" do
        expect(flash[:info]).to eq I18n.t("order_historys.index.info")
      end

      it "redirect to  root_path" do
        response.should redirect_to(root_url)
      end
    end
  end

  describe "GET #show" do
    context "when payment is present" do
      let!(:payment1) {FactoryBot.create :payment}
      before {get :show, params: {id: payment1.id}}
      it "assigns payment" do
        expect(assigns :payment).to eq payment1
      end
    end

    context "when payment is not present" do
      before {get :show, params: {id: 0}}
      it "show flash message" do
        expect(flash[:danger]).to eq I18n.t("order_historys.show.danger")
      end

      it "redirect to  order hisory path" do
        response.should redirect_to(order_historys_path)
      end
    end
  end
end
