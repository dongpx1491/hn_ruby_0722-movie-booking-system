class Ability
  include CanCan::Ability

  def initialize user
    can %i(read sort), Movie
    can :read, Genre
    can :read, Show
    can :manage, :password_reset
    can :create, User
    return if user.blank?

    can %i(read update), User, id: user.id
    can %i(manage activation), Payment, user: user
    cannot :delete, Payment, status: :active
    can :manage, Ticket, user: user
    can :manage, :order_history, user: user
    can :manage, :favorite, user: user
    return unless user.admin?

    can :manage, :all
    cannot :delete, Payment, status: :active
  end
end
