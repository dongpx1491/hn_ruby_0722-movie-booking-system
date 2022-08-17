class User < ApplicationRecord
  USER_ATTRS = %i(name date_of_birth phone_number email password
                  password_confirmation).freeze

  before_save :downcase_email

  enum role: {customer: 0, admin: 1}
  has_many :ratings, dependent: :destroy
  has_many :user_discounts, dependent: :destroy
  has_many :discounts, through: :user_discounts, dependent: :destroy

  validates :email, presence: true,
            length: {minium: Settings.user.email.min_length,
                     maximum: Settings.user.email.max_length},
            format: {with: Settings.user.valid_email_regex},
            uniqueness: {case_sensitive: false}

  validates :name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :password, presence: true,
            length: {minimum: Settings.user.password.min_length}, if: :password
  validates :phone_number, presence: true,
            length: {is: Settings.user.phone_number.length}
  validates :date_of_birth, presence: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
