class AddIndexToMovieTitle < ActiveRecord::Migration[6.1]
  def change
    add_index :movies, :title, unique: true 
  end
end
