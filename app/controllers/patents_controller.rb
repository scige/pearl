class PatentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @patents = Patent.all
  end

  def show
    @patent = Patent.find(params[:id])
    @users = get_my_group_users
  end

  def new
    @patent = Patent.new
    @users = get_my_group_users
  end

  def edit
    @patent = Patent.find(params[:id])
    @users = get_my_group_users
  end

  def create
    user_id = params[:patent].delete(:user_id)
    user = User.find(user_id)
    @patent = Patent.new(params[:patent])
    @patent.user = user

    if @patent.save
      redirect_to @patent
    else
      render action: "new"
    end
  end

  def update
    user_id = params[:patent].delete(:user_id)
    user = User.find(user_id)
    @patent = Patent.find(params[:id])
    @patent.user = user

    if @patent.update_attributes(params[:patent])
      redirect_to @patent
    else
      render action: "edit"
    end
  end

  def destroy
    @patent = Patent.find(params[:id])
    @patent.destroy

    redirect_to patents_url
  end
end
