class UserDiscount < ApplicationRecord
  belong_to :user
  belong_to :discount
end
