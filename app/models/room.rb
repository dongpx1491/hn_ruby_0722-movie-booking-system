class Room < ApplicationRecord
  belong_to :show
  has_many :seats, dependent: :destroy
end
