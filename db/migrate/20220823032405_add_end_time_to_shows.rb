class AddEndTimeToShows < ActiveRecord::Migration[6.1]
  def change
    add_column :shows, :end_time, :time
  end
end
