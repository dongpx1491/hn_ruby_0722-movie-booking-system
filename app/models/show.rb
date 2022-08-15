class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :tickets, dependent: :destroy
  SHOW_ATTR = %i(date start_time movie_id room_id end_time).freeze
  after_save :update_end_time
  validate :check_overlap_time_first, :check_overlap_time_second,
           :check_overlap_time_third, :check_overlap_time_fourth

  validates :date, date: {after: proc{Time.zone.now}}, on: :save

  scope :incre_order, ->{order id: :asc}
  scope :asc_date, ->{order date: :asc}
  scope :asc_time, ->{order start_time: :asc}

  delegate :title, to: :movie, prefix: :movie
  delegate :name, to: :room, prefix: :room

  def check_overlap_time_first
    end_time = start_time + (movie.duration / 60.0).hours
    time_checker = Show.where("date = ? AND
    (start_time < ADDTIME(?, '30:00') AND end_time > ADDTIME(?, '30:00'))
    AND room_id = ?", date, end_time, end_time, room_id)

    return if (time_checker - [self]).blank?

    errors.add(:start_time,
               "Times overlap another showtime on this screen
               #{time_checker.map(&:id)}")
  end

  def check_overlap_time_second
    time_checker = Show.where("date = ? AND
    (start_time < DATE_SUB(?, INTERVAL 30 MINUTE)
    AND end_time > DATE_SUB(?, INTERVAL 30 MINUTE))
    AND room_id = ?", date, start_time, start_time, room_id)

    return if (time_checker - [self]).blank?

    errors.add(:start_time,
               "Times overlap another showtime on this screen
               #{time_checker.map(&:id)}")
  end

  def check_overlap_time_third
    end_time = start_time + (movie.duration / 60.0).hours
    time_checker = Show.where("date = ? AND
    (end_time < ADDTIME(?, '30:00')
    AND start_time > DATE_SUB(?, INTERVAL 30 MINUTE))
    AND room_id = ?", date, end_time, start_time, room_id)

    return if (time_checker - [self]).blank?

    errors.add(:start_time,
               "Times overlap another showtime on this screen
               #{time_checker.map(&:id)}")
  end

  def check_overlap_time_fourth
    end_time = start_time + (movie.duration / 60.0).hours
    time_checker = Show.where("date = ? AND
    (end_time > ADDTIME(?, '30:00')
    AND start_time < DATE_SUB(?, INTERVAL 30 MINUTE))
    AND room_id = ?", date, end_time, start_time, room_id)
    return if (time_checker - [self]).blank?

    errors.add(:start_time,
               "Times overlap another showtime on this screen
               #{time_checker.map(&:id)}")
  end

  def update_end_time
    end_time = start_time + (movie.duration / 60.0).hours
    update_columns end_time: end_time
  end
end
