class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :tickets, dependent: :destroy
  SHOW_ATTR = %i(date start_time movie_id room_id end_time).freeze
  after_save :update_end_time
  validate :check_duration_time

  scope :incre_order, ->{order id: :asc}
  scope :asc_date, ->{order date: :asc}
  scope :asc_time, ->{order start_time: :asc}

  delegate :title, to: :movie, prefix: :movie
  delegate :name, to: :room, prefix: :room

  def check_duration_time
    time_checker = Show.where("date = ? AND (start_time < ? OR end_time > ?)
    AND room_id = ?", date, end_time, start_time, room_id)

    return if time_checker.none?

    errors.add(:start_time, t("overlap"))
  end

  def update_end_time
    end_time = start_time + (movie.duration / 60.0).hours
    update_columns end_time: end_time
  end
end
