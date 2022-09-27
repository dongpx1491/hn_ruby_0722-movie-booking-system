class Movie < ApplicationRecord
  enum status: {inactive: 0, active: 1}
  belongs_to :genre
  has_one_attached :image
  has_many :ratings, dependent: :destroy
  has_many :shows, dependent: :destroy

  MOVIE_ATTR = %i(title description release_date duration language cast
  director genre_id image).freeze

  delegate :name, to: :genre, prefix: true

  ransack_alias :genre, :genre_name

  validates :title, presence: true,
  length: {maximum: Settings.movie.name.max_length}, uniqueness: true
  validates :description, presence: true,
  length: {maximum: Settings.movie.content.max_length}
  validates :release_date, presence: true
  validates_date :release_date, after: Time.zone.now, on: :save
  validates :duration, :language, :cast, :director, presence: true

  scope :release, ->{where "release_date >= ?", Time.zone.now}
  scope :latest, ->{order created_at: :desc}
  scope :incre_order, ->{order(id: :asc)}
  scope :active, ->{where status: :active}

  def display_image
    image.variant(resize_to_limit: Settings.movie.image.image_movie)
  end
end
