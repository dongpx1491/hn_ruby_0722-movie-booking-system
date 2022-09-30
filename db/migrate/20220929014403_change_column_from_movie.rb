class ChangeColumnFromMovie < ActiveRecord::Migration[6.1]
  def change
    change_column :movies, :duration, :integer
  end
end
