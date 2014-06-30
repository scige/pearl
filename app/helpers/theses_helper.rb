module ThesesHelper
  def generate_all_theses_status
    [
      [Setting.theses.status_proposal_string, Setting.theses.status_proposal],
      [Setting.theses.status_research_string, Setting.theses.status_research],
      [Setting.theses.status_finish_string, Setting.theses.status_finish]
    ]
  end

  def get_thesis_status_string(status)
    if status == Setting.theses.status_proposal
      Setting.theses.status_proposal_string
    elsif status == Setting.theses.status_research
      Setting.theses.status_research_string
    elsif status == Setting.theses.status_finish
      Setting.theses.status_finish_string
    end
  end
end
