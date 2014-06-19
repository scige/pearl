# coding: utf-8

class PapersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @papers = []
    if current_user.group
      root_group = get_root_group(current_user)
      all_papers = Paper.all
      all_papers.each do |paper|
        if get_root_group(paper.user) == root_group
          @papers << paper
        end
      end
    end
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
      history = History.new(:category=>Setting.histories.category_paper, :detail_id=>@paper.id, :action=>Setting.histories.action_create)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to @paper
    else
      flash[:error] = "输入内容缺失或存在错误，新建论文失败！"
      redirect_to new_paper_url
    end
  end

  def update
    user_id = params[:paper].delete(:user_id)
    user = User.find(user_id)
    @paper = Paper.find(params[:id])
    @paper.user = user

    if @paper.update_attributes(params[:paper])
      history = History.new(:category=>Setting.histories.category_paper, :detail_id=>@paper.id, :action=>Setting.histories.action_update)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to @paper
    else
      flash[:error] = "输入内容缺失或存在错误，编辑论文失败！"
      redirect_to edit_paper_url(@paper)
    end
  end

  def destroy
    @paper = Paper.find(params[:id])
    history = History.new(:category=>Setting.histories.category_paper, :detail_id=>@paper.id, :action=>Setting.histories.action_destroy)
    history.user = current_user    #当前正在操作的user，而不是负责人
    history.group = get_root_group(current_user)
    history.save
    @paper.destroy

    redirect_to papers_url
  end
end
