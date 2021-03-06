module PatentsHelper
  def generate_all_patent_status
    [
      [Setting.patents.status_plan_string, Setting.patents.status_plan],
      [Setting.patents.status_writing_string, Setting.patents.status_writing],
      [Setting.patents.status_processing_string, Setting.patents.status_processing],
      [Setting.patents.status_publication_string, Setting.patents.status_publication],
      [Setting.patents.status_reality_string, Setting.patents.status_reality],
      [Setting.patents.status_authorization_string, Setting.patents.status_authorization]
    ]
  end

  def get_patent_status_string(status)
    if status == Setting.patents.status_plan
      Setting.patents.status_plan_string
    elsif status == Setting.patents.status_writing
      Setting.patents.status_writing_string
    elsif status == Setting.patents.status_processing
      Setting.patents.status_processing_string
    elsif status == Setting.patents.status_publication
      Setting.patents.status_publication_string
    elsif status == Setting.patents.status_reality
      Setting.patents.status_reality_string
    elsif status == Setting.patents.status_authorization
      Setting.patents.status_authorization_string
    end
  end
end
