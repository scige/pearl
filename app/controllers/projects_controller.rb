class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = []
    if current_user.group
      root_group = get_root_group(current_user)
      all_projects = Project.all
      all_projects.each do |project|
        if get_root_group(project.user) == root_group
          @projects << project
        end
      end
    end
  end

  def show
    @project = Project.find(params[:id])
    @users = get_my_group_users
  end

  def new
    @project = Project.new
    @users = get_my_group_users
  end

  def edit
    @project = Project.find(params[:id])
    @users = get_my_group_users
  end

  def create
    user_id = params[:project].delete(:user_id)
    user = User.find(user_id)
    @project = Project.new(params[:project])
    @project.user = user

    if @project.save
      history = History.new(:category=>Setting.histories.category_project, :detail_id=>@project.id, :action=>Setting.histories.action_create)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to @project
    else
      render action: "new"
    end
  end

  def update
    user_id = params[:project].delete(:user_id)
    user = User.find(user_id)
    @project = Project.find(params[:id])
    @project.user = user

    if @project.update_attributes(params[:project])
      history = History.new(:category=>Setting.histories.category_project, :detail_id=>@project.id, :action=>Setting.histories.action_update)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to @project
    else
      render action: "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    history = History.new(:category=>Setting.histories.category_project, :detail_id=>@project.id, :action=>Setting.histories.action_destroy)
    history.user = current_user    #当前正在操作的user，而不是负责人
    history.group = get_root_group(current_user)
    history.save
    @project.destroy

    redirect_to projects_url
  end
end