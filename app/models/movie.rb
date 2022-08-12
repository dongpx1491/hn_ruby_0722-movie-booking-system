class Movie < ApplicationRecord
  enum status: {inactive: 0, active: 1}
  belongs_to :genre
  has_one_attached :image
  has_many :ratings, dependent: :destroy
  has_many :shows, dependent: :destroy
end
