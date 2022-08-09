class Show < ApplicationRecord
  belong_to :movie
  has_one :room, dependent: :destroy
  has_many :tickets, dependent: :destroy
end
