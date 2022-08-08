class CreateShows < ActiveRecord::Migration[6.1]
  def change
    create_table :shows do |t|
      t.date :date
      t.time :start_time

      t.references :movie, null: true, foreign_key: true
      t.references :room, null: true, foreign_key: true

      t.timestamps
    end
  end
end
