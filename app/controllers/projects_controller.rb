class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = Project.all
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
      redirect_to @project
    else
      render action: "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_url
  end
end
