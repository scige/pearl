class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = get_my_group_users
  end

  def show
    @user = User.find(params[:id])
  end

  def select_group
    group = Group.find(params[:user][:group_id])
    current_user.group = group

    if current_user.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def edit_profile
    @user = User.find(params[:id])
    @groups = get_my_group_groups
  end

  def update_profile
    group_id = params[:user].delete(:group_id)
    group = Group.find(group_id)
    user_id = params[:user].delete(:user_id)
    user = User.find(user_id)
    user.group = group

    if user.update_attributes(params[:user])
      redirect_to users_url
    else
      redirect_to users_url
    end
  end

  def cancel_user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url
  end
end
