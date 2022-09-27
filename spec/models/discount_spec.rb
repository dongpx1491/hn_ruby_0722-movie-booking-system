require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "association" do
    it {should have_many(:payments).dependent(:destroy)}
    it {should have_many(:user_discounts).dependent(:destroy)}
    it {should have_many(:users).through(:user_discounts).dependent(:destroy)}
  end
end
