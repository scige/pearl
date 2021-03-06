module ProjectsHelper
  def generate_all_project_categories
    [
      [Setting.projects.category_vertical_string, Setting.projects.category_vertical],
      [Setting.projects.category_horizontal_string, Setting.projects.category_horizontal]
    ]
  end

  def generate_all_project_status
    [
      [Setting.projects.status_plan_string, Setting.projects.status_plan],
      [Setting.projects.status_writing_string, Setting.projects.status_writing],
      [Setting.projects.status_applying_string, Setting.projects.status_applying],
      [Setting.projects.status_reviewing_string, Setting.projects.status_reviewing],
      [Setting.projects.status_proceeding_string, Setting.projects.status_proceeding],
      [Setting.projects.status_acceptance_string, Setting.projects.status_acceptance],
      [Setting.projects.status_finish_string, Setting.projects.status_finish]
    ]
  end

  def get_project_category_string(category)
    if category == Setting.projects.category_vertical
      Setting.projects.category_vertical_string
    elsif category == Setting.projects.category_horizontal
      Setting.projects.category_horizontal_string
    end
  end

  def get_project_status_string(status)
    if status == Setting.projects.status_plan
      Setting.projects.status_plan_string
    elsif status == Setting.projects.status_writing
      Setting.projects.status_writing_string
    elsif status == Setting.projects.status_applying
      Setting.projects.status_applying_string
    elsif status == Setting.projects.status_reviewing
      Setting.projects.status_reviewing_string
    elsif status == Setting.projects.status_proceeding
      Setting.projects.status_proceeding_string
    elsif status == Setting.projects.status_acceptance
      Setting.projects.status_acceptance_string
    elsif status == Setting.projects.status_finish
      Setting.projects.status_finish_string
    end
  end
end
