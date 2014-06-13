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
end
