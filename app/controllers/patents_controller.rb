# coding: utf-8

class PatentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @patents = []
    if current_user.group
      root_group = get_root_group(current_user)
      all_patents = Patent.all
      all_patents.each do |patent|
        if get_root_group(patent.user) == root_group
          @patents << patent
        end
      end
    end
  end

  def show
    @object = Patent.find(params[:id])
    @users = get_my_group_users
    @documents = @object.documents
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
      history = History.new(:category=>Setting.histories.category_patent, :detail_id=>@patent.id, :action=>Setting.histories.action_create)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to @patent
    else
      flash[:error] = "输入内容缺失或存在错误，新建专利失败！"
      redirect_to new_patent_url
    end
  end

  def update
    user_id = params[:patent].delete(:user_id)
    user = User.find(user_id)
    @patent = Patent.find(params[:id])
    @patent.user = user

    if @patent.update_attributes(params[:patent])
      history = History.new(:category=>Setting.histories.category_patent, :detail_id=>@patent.id, :action=>Setting.histories.action_update)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to @patent
    else
      flash[:error] = "输入内容缺失或存在错误，编辑专利失败！"
      redirect_to edit_patent_url(@patent)
    end
  end

  def destroy
    @patent = Patent.find(params[:id])
    history = History.new(:category=>Setting.histories.category_patent, :detail_id=>@patent.id, :action=>Setting.histories.action_destroy)
    history.user = current_user    #当前正在操作的user，而不是负责人
    history.group = get_root_group(current_user)
    history.save
    @patent.destroy

    redirect_to patents_url
  end
end
