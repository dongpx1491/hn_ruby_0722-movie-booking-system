class Room < ApplicationRecord
  has_many :seats, dependent: :destroy
  has_many :shows, dependent: :destroy

  scope :incre_order, ->{order(id: :asc)}
end
