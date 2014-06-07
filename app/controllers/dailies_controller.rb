# coding: utf-8

class DailiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @dailies = Daily.all
    @daily = Daily.new
    @query_date = Time.now.strftime("%Y-%m-%d")
  end

  def someday
    @query_date = params[:date]
    @query_date = Time.now.strftime("%Y-%m-%d") unless @query_date
    dailies = Daily.where("date like ?", "#{@query_date}%").order("id DESC")
    dailies = dailies.select {|daily| current_user and daily.user == current_user}
    @cur_daily = dailies.first if dailies and dailies.size > 0
    @daily = Daily.new
  end

  def group
    @query_date = params[:date]
    @query_date = Time.now.strftime("%Y-%m-%d") unless @query_date
    dailies = Daily.where("date like ?", "#{@query_date}%").order("id DESC")
    users = get_my_group_users
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

    @send_percent = group_dailies_count * 1.0 / users.size * 100
  end

  def show
    @daily = Daily.find(params[:id])
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
        redirect_to "/dailies/someday/#{@daily.date.strftime("%Y-%m-%d")}"
        return
      end
    end

    #不允许提前写以后日期的日报
    if @daily.date.strftime("%Y-%m-%d") > Time.now.strftime("%Y-%m-%d")
      redirect_to "/dailies/someday/#{@daily.date.strftime("%Y-%m-%d")}"
      return
    end

    if @daily.save
      redirect_to "/dailies/someday/#{@daily.date.strftime("%Y-%m-%d")}"
    else
      render action: "new"
    end
  end

  def update
    @daily = Daily.find(params[:id])

    if @daily.update_attributes(params[:daily])
      redirect_to "/dailies/someday/#{@daily.date.strftime("%Y-%m-%d")}"
    else
      render action: "edit"
    end
  end

  def destroy
    @daily = Daily.find(params[:id])
    @daily.destroy

    redirect_to dailies_url
  end
end
