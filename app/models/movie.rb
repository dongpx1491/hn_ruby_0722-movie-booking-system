class Movie < ApplicationRecord
  enum status: {inactive: 0, active: 1}
  belong_to :genre
  has_many :ratings, dependent: :destroy
  has_many :shows, dependent: :destroy
end
