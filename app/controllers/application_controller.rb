class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :user_access_log

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, :alert => exception.message
  end

  def user_access_log
    session_id = session[:session_id] || ""
    user_id = (current_user && current_user.id) || ""
    user_name = (current_user && current_user.name) || ""
    STAT_LOGGER.info "[access]\t#{request.request_method}\t#{request.url}\t#{request.referer}\t#{request.remote_ip}\t#{request.user_agent}\t#{session_id}\t#{user_id}\t#{user_name}"
  end

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
