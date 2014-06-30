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

  def my
    @theses = current_user.theses
  end

  def show
    @object = Thesis.find(params[:id])
    @documents = @object.documents
  end

  def new
    @thesis = Thesis.new
  end

  def edit
    @thesis = Thesis.find(params[:id])
  end

  def create
    @thesis = Thesis.new(params[:thesis])
    @thesis.user = current_user

    if @thesis.save
      redirect_to @thesis
    else
      flash[:error] = "输入内容缺失或存在错误，新建学位论文失败！"
      redirect_to new_thesis_url
    end
  end

  def update
    @thesis = Thesis.find(params[:id])
    @thesis.user = current_user

    if @thesis.update_attributes(params[:thesis])
      redirect_to @thesis
    else
      flash[:error] = "输入内容缺失或存在错误，编辑学位论文失败！"
      redirect_to edit_thesis_url(@thesis)
    end
  end

  def destroy
    @thesis = Thesis.find(params[:id])
    @thesis.destroy
    redirect_to theses_url
  end
end
