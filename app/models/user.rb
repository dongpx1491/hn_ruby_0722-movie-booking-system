class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable,
         omniauth_providers: [:facebook, :google_oauth2]

  USER_ATTRS = %i(id name date_of_birth phone_number email).freeze

  before_save :downcase_email

  enum role: {customer: 0, admin: 1}
  has_many :ratings, dependent: :destroy
  has_many :user_discounts, dependent: :destroy
  has_many :discounts, through: :user_discounts, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :movies, through: :favorites
  validates :email, presence: true,
            length: {minium: Settings.user.email.min_length,
                     maximum: Settings.user.email.max_length},
            uniqueness: {case_sensitive: false}

  validates :name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :password, presence: true,
            length: {minimum: Settings.user.password.min_length}, if: :password
  validates :phone_number,
            length: {is: Settings.user.phone_number.length},
            allow_nil: true

  class << self
    def omniauth_user auth
      where(provider: auth.provider,
            uid: auth.uid).first_or_initialize do |user|
        user.name = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.uid = auth.uid
        user.provider = auth.provider
      end
    end
  end

  scope :incre_order, ->{order(id: :asc)}
  scope :get_user, ->{select(USER_ATTRS).where(role: 0)}

  private

  def downcase_email
    email.downcase!
  end
end
