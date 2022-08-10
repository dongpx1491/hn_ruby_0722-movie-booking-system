class Room < ApplicationRecord
  belongs_to :show
  has_many :seats, dependent: :destroy
end
