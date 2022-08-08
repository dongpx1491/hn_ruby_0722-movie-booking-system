class Rating < ApplicationRecord
  belong_to :movie
  belong_to :user
end
