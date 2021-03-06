# coding: utf-8

class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:create]

  def create
    daily_id = params[:comment].delete(:daily_id)
    @daily = Daily.find(daily_id)
    @comment = Comment.new(params[:comment])
    @comment.daily = @daily
    @comment.user = current_user

    if @comment.save
      history = History.new(:category=>Setting.histories.category_daily_comment, :detail_id=>@comment.id, :action=>Setting.histories.action_create)
      history.user = current_user    #当前正在操作的user，而不是负责人
      history.group = get_root_group(current_user)
      history.save
      redirect_to @daily
    else
      redirect_to @daily
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @daily = @comment.daily
    @comment.destroy

    redirect_to @daily
  end
end
