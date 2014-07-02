# coding: utf-8

class DailiesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  #def index
  #  @dailies = Daily.all
  #  @daily = Daily.new
  #  @query_date = Time.now.strftime("%Y-%m-%d")
  #end

  def my
    @query_date = params[:date]
    @query_date = Time.now.strftime("%Y-%m-%d") unless @query_date
    dailies = Daily.where("date like ?", "#{@query_date}%").order("id DESC")
    dailies = dailies.select {|daily| current_user and daily.user == current_user}
    @cur_daily = dailies.first if dailies and dailies.size > 0
    @daily = Daily.new
  end

  def group
    group_implement(false)
  end

  def subgroup
    group_implement(true)
  end

  def show
    @daily = Daily.find(params[:id])
    @comments = @daily.comments
    @comment = Comment.new
    @floor = 0
  end

  def new
    @daily = Daily.new
  end

  def edit
    @daily = Daily.find(params[:id])
    @query_date = @daily.date.strftime("%Y-%m-%d") if @daily
  end

  def create
    @daily = Daily.new(params[:daily])
    @daily.user = current_user

    #每天只允许写一篇日报
    dailies = current_user.dailies
    dailies.each do |daily|
      if daily.date.strftime("%Y-%m-%d") == @daily.date.strftime("%Y-%m-%d")
        redirect_to "/dailies/my/#{@daily.date.strftime("%Y-%m-%d")}"
        return
      end
    end

    #不允许提前写以后日期的日报
    if @daily.date.strftime("%Y-%m-%d") > Time.now.strftime("%Y-%m-%d")
      redirect_to "/dailies/my/#{@daily.date.strftime("%Y-%m-%d")}"
      return
    end

    if @daily.save
      history = History.new(:category=>Setting.histories.category_daily, :detail_id=>@daily.id, :action=>Setting.histories.action_create)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to "/dailies/my/#{@daily.date.strftime("%Y-%m-%d")}"
    else
      render action: "new"
    end
  end

  def update
    @daily = Daily.find(params[:id])

    if @daily.update_attributes(params[:daily])
      history = History.new(:category=>Setting.histories.category_daily, :detail_id=>@daily.id, :action=>Setting.histories.action_update)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to "/dailies/my/#{@daily.date.strftime("%Y-%m-%d")}"
    else
      render action: "edit"
    end
  end

  def destroy
    @daily = Daily.find(params[:id])
    history = History.new(:category=>Setting.histories.category_daily, :detail_id=>@daily.id, :action=>Setting.histories.action_destroy)
    history.user = current_user    #当前正在操作的user，而不是负责人
    history.group = get_root_group(current_user)
    history.save
    @daily.destroy

    redirect_to dailies_url
  end

  private

  def group_implement(is_subgroup)
    @query_date = params[:date]
    @query_date = Time.now.strftime("%Y-%m-%d") unless @query_date
    dailies = Daily.where("date like ?", "#{@query_date}%").order("id DESC")
    users = []
    if is_subgroup
      unless current_user.group.root?
        users = current_user.group.users
      end
    else
      users = get_my_group_users
    end
    #只显示学生的日报
    users = users.select {|u| u.identity == Setting.users.identity_student}
    users.sort! do |l,r|       
      if l.grade and r.grade == nil
        -1
      elsif l.grade == nil and r.grade
        1
      elsif l.grade == nil and r.grade == nil
        0
      else
        r.grade<=>l.grade
      end
    end
    group_dailies_count = 0
    @users_dailies = []
    users.each do |user|
      is_find = false
      dailies.each do |daily|
        if daily.user == user
          if daily.date.strftime("%Y-%m-%d") < daily.created_at.strftime("%Y-%m-%d")
            @users_dailies << {:user=>user, :status=>Setting.dailies.send_overdate, :daily=>daily}
          else
            @users_dailies << {:user=>user, :status=>Setting.dailies.send_ontime, :daily=>daily}
          end
          is_find = true
          group_dailies_count += 1
          break
        end
      end
      
      @users_dailies << {:user=>user, :status=>Setting.dailies.send_not, :daily=>nil} unless is_find
    end

    @send_percent = 0
    @send_percent = (group_dailies_count * 1.0 / users.size * 100 ).to_i if users.size > 0
  end
end
