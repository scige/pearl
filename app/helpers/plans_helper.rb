module PlansHelper
  def get_plan_status_style(status)
    if status == Setting.plans.status_none
      "glyphicon-tag"
    elsif status == Setting.plans.status_active
      "glyphicon-play"
    elsif status == Setting.plans.status_finish
      "glyphicon-ok"
    elsif status == Setting.plans.status_canceled
      "glyphicon-remove"
    elsif status == Setting.plans.status_postponed
      "glyphicon-time"
    end
  end

  def generate_all_plan_status
    [
      [Setting.plans.status_none_string, Setting.plans.status_none],
      [Setting.plans.status_active_string, Setting.plans.status_active],
      [Setting.plans.status_finish_string, Setting.plans.status_finish],
      [Setting.plans.status_canceled_string, Setting.plans.status_canceled],
      [Setting.plans.status_postponed_string, Setting.plans.status_postponed]
    ]
  end
end
