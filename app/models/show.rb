class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :tickets, dependent: :destroy

  scope :asc_date, ->{order date: :asc}
  scope :asc_time, ->{order start_time: :asc}
end
