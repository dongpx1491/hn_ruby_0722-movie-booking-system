class Ticket < ApplicationRecord
  belongs_to :show
  belongs_to :seat
  belongs_to :payment
end
