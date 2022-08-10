class Seat < ApplicationRecord
  belongs_to :ticket
  belongs_to :room
end
