class Movie < ApplicationRecord
  enum status: {inactive: 0, active: 1}
  belongs_to :genre
  has_one_attached :image
  has_many :ratings, dependent: :destroy
  has_many :shows, dependent: :destroy
  has_one_attached :image

  scope :release, ->{where "release_date >= ?", Time.zone.now}
  scope :limitation, ->{limit Settings.model.limitation}
end
