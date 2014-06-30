# coding: utf-8

class ThesesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @theses = []
    if current_user.group
      root_group = get_root_group(current_user)
      all_theses = Thesis.all
      all_theses.each do |thesis|
        if get_root_group(thesis.user) == root_group
          @theses << thesis
        end
      end
    end
  end

  def show
    @object = Thesis.find(params[:id])
    @users = get_my_group_users
    @documents = @object.documents
  end

  def new
    @thesis = Thesis.new
    @users = get_my_group_users
  end

  def edit
    @thesis = Thesis.find(params[:id])
    @users = get_my_group_users
  end

  def create
    user_id = params[:thesis].delete(:user_id)
    user = User.find(user_id)
    @thesis = Thesis.new(params[:thesis])
    @thesis.user = user

    if @thesis.save
      redirect_to @thesis
    else
      flash[:error] = "输入内容缺失或存在错误，新建论文失败！"
      redirect_to new_thesis_url
    end
  end

  def update
    user_id = params[:thesis].delete(:user_id)
    user = User.find(user_id)
    @thesis = Thesis.find(params[:id])
    @thesis.user = user

    if @thesis.update_attributes(params[:thesis])
      redirect_to @thesis
    else
      flash[:error] = "输入内容缺失或存在错误，编辑论文失败！"
      redirect_to edit_thesis_url(@thesis)
    end
  end

  def destroy
    @thesis = Thesis.find(params[:id])
    @thesis.destroy
    redirect_to theses_url
  end
end
