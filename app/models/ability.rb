# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, Category
      can :read, Post
      can :read, User
    else
      case user.role.name
      when 'admin'
        can :manage, Category
        can %i[read destroy make_admin make_user], User
        can :manage, User, id: user.id
        can :manage, Role
        can %i[read destroy approve_post decline_post], Post
        can :read, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin'
      when 'user'
        can :read, Category
        can :read, Post
        can :read, User
        can %i[create update destroy submit_post undo_submit], Post, user_id: user.id
        can %i[read destroy update], User, id: user.id
      end
    end
  end
end
