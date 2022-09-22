class RemoveColumTypeFromRating < ActiveRecord::Migration[6.1]
  def change
    remove_column :ratings, :favorite, :boolean
  end
end
