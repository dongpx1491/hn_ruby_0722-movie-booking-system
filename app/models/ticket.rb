class Ticket < ApplicationRecord
  belongs_to :show
  belongs_to :seat
  belongs_to :payment
  delegate :id, :price, :type_seat, to: :seat, prefix: true
  delegate :date, :start_time, :movie, :room, to: :show, prefix: true
  delegate :image, :thumbnail, :title, to: :movie, prefix: true
end
