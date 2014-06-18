# coding: utf-8

class HomeController < ApplicationController
  def index
    @groups = Group.roots
    @histories = []
    if current_user and current_user.group
      @histories = get_root_group(current_user).histories

      #近两天动态
      unless params[:all]
        @histories = @histories.select {|h| h.created_at.strftime('%Y年%m月%d日') == Time.now.strftime('%Y年%m月%d日') or h.created_at.strftime('%Y年%m月%d日') == (Time.now-1.day).strftime('%Y年%m月%d日')}
      end
      @histories.sort! {|l,r| r.id<=>l.id}

      #去除连续的重复动态
      if @histories.size > 0
        last_history = @histories[0]
        temp_histories = []
        @histories.each do |history|
          if history.category != last_history.category or history.detail_id != last_history.detail_id
            temp_histories << last_history
          end
          last_history = history
        end
        temp_histories << last_history
        @histories = temp_histories
      end
    end

    @all_histories = []
    @projects = []
    @papers = []
    @patents = []
    @dailies = []
    @comments = []
    @histories.each do |history|
      if history.category == Setting.histories.category_project
        object = Project.find(history.detail_id)
        temp_hash = {:history=>history, :title=>object.title, :operator=>history.user, :action=>get_action_string(history.action), :object=>object, :panel_style=>"panel-info", :panel_head_title=>"项目动态", :is_show_author=>true}
        @projects << temp_hash
        @all_histories << temp_hash
      elsif history.category == Setting.histories.category_paper
        object = Paper.find(history.detail_id)
        temp_hash = {:history=>history, :title=>object.title, :operator=>history.user, :action=>get_action_string(history.action), :object=>object, :panel_style=>"panel-success", :panel_head_title=>"论文动态", :is_show_author=>true}
        @papers << temp_hash
        @all_histories << temp_hash
      elsif history.category == Setting.histories.category_patent
        object = Patent.find(history.detail_id)
        temp_hash = {:history=>history, :title=>object.title, :operator=>history.user, :action=>get_action_string(history.action), :object=>object, :panel_style=>"panel-warning", :panel_head_title=>"专利动态", :is_show_author=>true}
        @patents << temp_hash
        @all_histories << temp_hash
      elsif history.category == Setting.histories.category_daily
        object = Daily.find(history.detail_id)
        temp_hash = {:history=>history, :title=>"#{object.date.strftime('%Y年%m月%d日')}日报", :operator=>history.user, :action=>get_action_string(history.action), :object=>object, :panel_style=>"panel-danger", :panel_head_title=>"日报动态", :is_show_author=>false}
        @dailies << temp_hash
        @all_histories << temp_hash
      elsif history.category == Setting.histories.category_daily_comment
        object = Comment.find(history.detail_id)
        temp_hash = {:history=>history, :title=>"#{object.daily.date.strftime('%Y年%m月%d日')}日报", :operator=>history.user, :action=>get_comment_action_string(history.action), :object=>object.daily, :panel_style=>"panel-danger", :panel_head_title=>"日报动态", :is_show_author=>true}
        @comments << temp_hash
        @all_histories << temp_hash
      end
    end
  end

  private

  def get_action_string(action)
    if action == Setting.histories.action_create
      Setting.histories.action_create_string
    elsif action == Setting.histories.action_update
      Setting.histories.action_update_string
    elsif action == Setting.histories.action_destroy
      Setting.histories.action_destroy_string
    end
  end

  def get_comment_action_string(action)
    if action == Setting.histories.action_create
      "评论了"
    elsif action == Setting.histories.action_update
      "更新了"
    elsif action == Setting.histories.action_destroy
      "删除了"
    end
  end
end
