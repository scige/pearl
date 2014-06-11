class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_my_group_groups
    groups = []
    if current_user.group.root?
      groups << current_user.group
      groups += current_user.group.children
    else
      groups << current_user.group.root
      groups += current_user.group.root.children
    end

    return groups
  end

  def get_my_group_users
    groups = get_my_group_groups

    users = []
    groups.each do |group|
      users += group.users
    end

    return users
  end

  def get_root_group(user)
    #前提是user.group不是nil
    if user.group.root?
      user.group
    else
      user.group.root
    end
  end
end
