# coding: utf-8

class HomeController < ApplicationController
  def index
    @groups = Group.roots
    @histories = []
    if current_user and current_user.group
      @histories = get_root_group(current_user).histories
    end
    @histories.sort! {|l,r| r.id<=>l.id}

    @projects = []
    @papers = []
    @patents = []
    @dailies = []
    @comments = []
    @histories.each do |history|
      if history.category == Setting.histories.category_project
        object = Project.find(history.detail_id)
        @projects << {:title=>object.title, :operator=>history.user, :action=>get_action_string(history.action), :object=>object}
      elsif history.category == Setting.histories.category_paper
        object = Paper.find(history.detail_id)
        @papers << {:title=>object.title, :operator=>history.user, :action=>get_action_string(history.action), :object=>object}
      elsif history.category == Setting.histories.category_patent
        object = Patent.find(history.detail_id)
        @patents << {:title=>object.title, :operator=>history.user, :action=>get_action_string(history.action), :object=>object}
      elsif history.category == Setting.histories.category_daily
        object = Daily.find(history.detail_id)
        @dailies << {:title=>"#{object.date.strftime('%Y年%m月%d日')}日报", :operator=>history.user, :action=>get_action_string(history.action), :object=>object}
      elsif history.category == Setting.histories.category_daily_comment
        object = Comment.find(history.detail_id)
        @comments << {:title=>"#{object.daily.date.strftime('%Y年%m月%d日')}日报", :operator=>history.user, :action=>get_comment_action_string(history.action), :object=>object}
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
