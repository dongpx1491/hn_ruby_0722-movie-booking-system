class Show < ApplicationRecord
  belongs_to :movie
  has_one :room, dependent: :destroy
  has_many :tickets, dependent: :destroy
end
