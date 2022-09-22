class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :comment, presence: true,
           length: {minimum: Settings.rating.comment.min_length,
                    maximum: Settings.rating.comment.max_length}

  delegate :name, to: :user, prefix: :user

  scope :latest, ->{order(created_at: :desc)}
  scope :top, ->{limit 5}
end
