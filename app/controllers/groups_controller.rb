# coding: utf-8

class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups = []
    if current_user.group
      if current_user.group.root?
        @groups = current_user.group.children
      else
        @groups = current_user.group.root.children
      end
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
        root_group = nil
        if current_user.group.root?
          root_group = current_user.group
        else
          root_group = current_user.group.root
        end
        @group.move_to_child_of(root_group)
      else
        current_user.group = @group
        current_user.save
      end
      redirect_to @group
    else
      render action: "new"
    end
  end

  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
      redirect_to @group, notice: 'Group was successfully updated.'
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
