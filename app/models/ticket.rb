class Ticket < ApplicationRecord
  belong_to :show
  belong_to :seat
  belong_to :payment
end
