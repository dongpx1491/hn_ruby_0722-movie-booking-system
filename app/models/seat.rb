class Seat < ApplicationRecord
  enum type_seat: {normal: 0, vip: 1}
  has_one :ticket, dependent: :destroy
  belongs_to :room
end
