class Room < ApplicationRecord
  has_many :seats, dependent: :destroy
  has_many :shows, dependent: :destroy
end
