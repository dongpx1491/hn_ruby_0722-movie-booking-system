require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:seat) {FactoryBot.create :seat}
  let!(:movie) {FactoryBot.create :movie}
  let!(:show) {FactoryBot.create :show, movie_id: movie.id}
  let!(:payment) {FactoryBot.create :payment, user_id: user.id}
  let!(:ticket) {FactoryBot.create :ticket, show_id: show.id, payment_id: payment.id, seat_id: seat.id}
  it {should use_before_action(:find_ticket)}
  before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_payment).and_return(payment)
      sign_in user
      allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe "POST #create" do
    context "when create ticket successful" do
      before {post :create, params: {movie_id: movie.id, ticket: {show_id: show.id,seat_id: seat.id ,payment_id: payment.id}}}

      it "flash success message" do
        expect(flash[:success]).to eq I18n.t("tickets.create.success")
      end

      it "redirect to movie show path" do
        response.should redirect_to movie_show_path(movie.id, show.id)
      end
    end

    context "when create ticket unsuccessful" do
       before {post :create, params: {movie_id: movie.id, ticket: {show_id: show.id}}}
       it "flash failure message" do
        expect(flash[:danger]).to eq I18n.t("tickets.create.danger")
       end
    end
  end

  describe "DELETE #destroy" do
    context "when delete ticket successful" do
      before {delete :destroy, params: {id: ticket.id}}
      context "when create ticket successful" do
        it "flash success message" do
          expect(flash[:success]).to eq I18n.t("tickets.destroy.success")
        end

        it "redirect to movie show path" do
          response.should redirect_to payment_path(payment)
        end
      end

      context "when delete ticket unsuccessful" do
        before {delete :destroy, params: {id: 0}}
        it "flash fail to din ticket message" do
          expect(flash[:warning]).to eq I18n.t("tickets.not_found")
        end

        it "redirect to movie show path" do
          response.should redirect_to payment_path(payment)
        end
      end
    end
  end
end
