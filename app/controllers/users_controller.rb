class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = get_my_group_users
  end

  def show
    @user = User.find(params[:id])
  end

  def edit_group
    @user = User.find(params[:id])
    @groups = get_my_group_groups
  end

  def select_group
    group = Group.find(params[:user][:group_id])
    current_user.group = group

    if current_user.save
      redirect_to users_url
    else
      render action: "edit"
    end
  end

  def update_group
    group = Group.find(params[:user][:group_id])
    user = User.find(params[:user][:user_id])
    user.group = group

    if user.save
      redirect_to users_url
    else
      render action: "edit"
    end
  end

  def cancel_user
  end
end
