class Movie < ApplicationRecord
  enum status: {inactive: 0, active: 1}
  belongs_to :genre
  has_one_attached :image
  has_many :ratings, dependent: :destroy
  has_many :shows, dependent: :destroy
  has_one_attached :image
  MOVIE_ATTR = %i(title description release_date duration language cast
  director genre_id).freeze

  delegate :name, to: :genre, prefix: true

  validates :title, presence: true,
  length: {maximum: Settings.movie.name.max_length}, uniqueness: true
  validates :description, presence: true,
  length: {maximum: Settings.movie.content.max_length}
  validates :release_date, presence: true,
  date: {after: proc{Time.zone.now}}, on: :save
  validates :duration, :language, :cast, :director, presence: true

  scope :release, ->{where "release_date >= ?", Time.zone.now}
  scope :latest, ->{order id: :desc}
  scope :incre_order, ->{order(id: :asc)}
  scope :search, (lambda do |key|
    where "title LIKE ? or description LIKE ?", "%#{key}%", "%#{key}%"
  end)
end
