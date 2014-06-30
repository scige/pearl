# coding: utf-8

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
    total_count = @projects.size
    @projects = @projects.select {|p| p.status != Setting.projects.status_finish}
    @not_finish_count = @projects.size
    @finish_count = total_count - @projects.size
  end

  def finish
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
    total_count = @projects.size
    @projects = @projects.select {|p| p.status == Setting.projects.status_finish}
    @not_finish_count = total_count - @projects.size
    @finish_count = @projects.size

    render "index"
  end

  def show
    @object = Project.find(params[:id])
    @users = get_my_group_users
    @documents = @object.documents
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
      flash[:error] = "输入内容缺失或存在错误，新建项目失败！"
      redirect_to new_project_url
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
      flash[:error] = "输入内容缺失或存在错误，编辑项目失败！"
      redirect_to edit_project_url(@project)
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
