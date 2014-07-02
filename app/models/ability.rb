# coding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)

    #user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    end

    #TODO: 限制跨团队资源的访问，只能访问本团队的资源

    if user.teacher?
      #Daily
      can :show, Daily
      can :create, Daily
      can :update, Daily do |daily|
        daily.user_id == user.id
      end
      can :my, Daily
      can :group, Daily
      can :subgroup, Daily

      #Comment
      can :create, Comment

      #Plan
      can :index, Plan
      can :create, Plan
      can :update, Plan do |plan|
        plan.user_id == user.id
      end
      can :destroy, Plan do |plan|
        plan.user_id == user.id
      end
      can :update_status, Plan do |plan|
        plan.user_id == user.id
      end
      can :user, Plan

      #User
      can :index, User
      can :show, User
      can :select_group, User do |u|
        user.group_id == nil
      end
      can :edit_profile, User
      can :update_profile, User
      can :cancel_user, User

      #Group
      can :read, Group do |group|
        if user.group.root? and group.root?
          user.group_id == group.id
        elsif user.group.root? and !group.root?
          user.group_id == group.root.id
        elsif !user.group.root? and group.root?
          user.group.root.id == group.id
        else
          user.group_id == group.id
        end
      end

      #Project
      can :read, Project
      can :create, Project
      can :update, Project
      can :destory, Project
      can :finish, Project

      #Paper
      can :read, Paper
      can :create, Paper
      can :update, Paper
      can :destory, Paper

      #Patent
      can :read, Patent
      can :create, Patent
      can :update, Patent
      can :destory, Patent

      #Thesis
      can :read, Thesis
      can :create, Thesis
      can :update, Thesis
      can :destory, Thesis
      can :my, Thesis

      #Document
      can :read, Document
      can :create, Document
      can :update, Document
      can :destory, Document

      #Review
      can :create, Review
    end

    if user.student?
      #Daily
      can :show, Daily do |daily|
        daily.user_id == user.id
      end
      can :create, Daily
      can :update, Daily do |daily|
        daily.user_id == user.id
      end
      can :my, Daily

      #Comment
      can :create, Comment

      #Plan
      can :index, Plan do |plan|
        plan.user_id == user.id
      end
      can :create, Plan
      can :update, Plan do |plan|
        plan.user_id == user.id
      end
      can :destroy, Plan do |plan|
        plan.user_id == user.id
      end
      can :update_status, Plan do |plan|
        plan.user_id == user.id
      end

      #User
      can :index, User
      can :show, User
      can :select_group, User do |u|
        user.group_id == nil
      end
      can :cancel_user, User

      #Group
      can :read, Group do |group|
        if user.group.root? and group.root?
        elsif user.group.root? and !group.root?
          user.group_id == group.root.id
        elsif !user.group.root? and group.root?
          user.group.root.id == group.id
        else
          user.group_id == group.id
        end
      end

      #Project
      can :read, Project
      can :create, Project
      can :update, Project do |project|
        project.user_id == user.id
      end
      can :destory, Project do |project|
        project.user_id == user.id
      end
      can :finish, Project

      #Paper
      can :read, Paper
      can :create, Paper
      can :update, Paper do |paper|
        paper.user_id == user.id
      end
      can :destory, Paper do |paper|
        paper.user_id == user.id
      end

      #Patent
      can :read, Patent
      can :create, Patent
      can :update, Patent do |patent|
        patent.user_id == user.id
      end
      can :destory, Patent do |patent|
        patent.user_id == user.id
      end

      #Thesis
      can :read, Thesis
      can :create, Thesis
      can :update, Thesis do |thesis|
        thesis.user_id == user.id
      end
      can :destory, Thesis do |thesis|
        thesis.user_id == user.id
      end
      can :my, Thesis

      #Document
      can :read, Document
      can :create, Document
      can :update, Document do |document|
        document.user_id == user.id
      end
      can :destory, Document do |document|
        document.user_id == user.id
      end

      #Review
      can :create, Review
    end


    #User, Group
    #Daily, Comment, Plan
    #Project, Paper, Patent, Thesis
    #Document, Review


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
