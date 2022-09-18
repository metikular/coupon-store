# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, User, id: user.id
    can :manage, Coupon, user: user
    can :manage, LoyaltyCard, user: user
  end
end
