# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  paper_id   :integer
#  patent_id  :integer
#  thesis_id  :integer
#

class Document < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :paper
  belongs_to :patent
  belongs_to :thesis

  attr_accessible :title, :content, :category

  validates :title,       :presence => true

  validates :user_id,     :presence => true

  validates :category,    :presence => true,
                          :numericality => {:only_integer => true}
end
