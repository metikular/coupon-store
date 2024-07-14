# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, User, id: user.id
    can :manage, :expiration_notification
    can :manage, Coupon, user: user
    can :manage, LoyaltyCard, user: user
    can :manage, :search
  end
end
