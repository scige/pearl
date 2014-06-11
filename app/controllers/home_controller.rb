class HomeController < ApplicationController
  def index
    @groups = Group.roots
    @histories = []
    if current_user and current_user.group
      @histories = get_root_group(current_user).histories
    end
    #@histories = History.order("id DESC")

    @projects = []
    @papers = []
    @patents = []
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
end
