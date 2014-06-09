class PapersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @papers = Paper.all
  end

  def show
    @paper = Paper.find(params[:id])
    @users = get_my_group_users
  end

  def new
    @paper = Paper.new
    @users = get_my_group_users
  end

  def edit
    @paper = Paper.find(params[:id])
    @users = get_my_group_users
  end

  def create
    user_id = params[:paper].delete(:user_id)
    user = User.find(user_id)
    @paper = Paper.new(params[:paper])
    @paper.user = user

    if @paper.save
      redirect_to @paper
    else
      render action: "new"
    end
  end

  def update
    user_id = params[:paper].delete(:user_id)
    user = User.find(user_id)
    @paper = Paper.find(params[:id])
    @paper.user = user

    if @paper.update_attributes(params[:paper])
      redirect_to @paper
    else
      render action: "edit"
    end
  end

  def destroy
    @paper = Paper.find(params[:id])
    @paper.destroy

    redirect_to papers_url
  end
end
