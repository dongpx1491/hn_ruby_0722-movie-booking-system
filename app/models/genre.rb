class Genre < ApplicationRecord
  has_many :movies, dependent: :destroy
  validates :name, presence: true,
            length: {maximum: Settings.genre.name.max_length},
            uniqueness: true

  scope :asc_genre_name, ->{order name: :asc}
end
