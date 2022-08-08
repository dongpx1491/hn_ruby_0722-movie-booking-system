class Seat < ApplicationRecord
  belong_to :ticket
  belong_to :room
end
