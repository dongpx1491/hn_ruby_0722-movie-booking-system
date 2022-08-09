class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.date :release_date
      t.time :duration
      t.string :language
      t.string :cast
      t.string :director
      t.boolean :status

      t.references :genre, null: true, foreign_key: true

      t.timestamps
    end
  end
end
