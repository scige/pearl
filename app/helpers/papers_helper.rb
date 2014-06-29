module PapersHelper
  def generate_all_paper_status
    [
      [Setting.papers.status_submit_string, Setting.papers.status_submit],
      [Setting.papers.status_accept_string, Setting.papers.status_accept],
      [Setting.papers.status_publish_string, Setting.papers.status_publish]
    ]
  end

  def get_paper_status_string(status)
    if status == Setting.papers.status_submit
      Setting.papers.status_submit_string
    elsif status == Setting.papers.status_accept
      Setting.papers.status_accept_string
    elsif status == Setting.papers.status_publish
      Setting.papers.status_publish_string
    end
  end
end
