# coding: utf-8

class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @root_group = nil
    @child_groups = []
    if current_user.group
      @root_group = get_root_group(current_user)
      @child_groups = @root_group.children
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group])

    #有团队就创建小组, 没有团队就创建团队
    if @group.save
      if current_user.group
        root_group = get_root_group(current_user)
        @group.move_to_child_of(root_group)
      else
        current_user.group = @group
        current_user.save
      end
      redirect_to groups_url
    else
      render action: "new"
    end
  end

  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
      redirect_to groups_url
    else
      render action: "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_url
  end
end
