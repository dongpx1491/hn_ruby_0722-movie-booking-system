class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  before_save :downcase_email

  enum role: {customer: 0, admin: 1}
  has_many :ratings, dependent: :destroy
  has_many :user_discounts, dependent: :destroy
  has_many :discounts, through: :user_discounts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :email, presence: true,
            length: {minium: Settings.user.email.min_length,
                     maximum: Settings.user.email.max_length},
            uniqueness: {case_sensitive: false}

  validates :name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :password, presence: true,
            length: {minimum: Settings.user.password.min_length}, if: :password
  validates :phone_number, presence: true,
            length: {is: Settings.user.phone_number.length}
  validates :date_of_birth, presence: true

  scope :incre_order, ->{order(id: :asc)}

  private

  def downcase_email
    email.downcase!
  end
end
