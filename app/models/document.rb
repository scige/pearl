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
#

class Document < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  attr_accessible :title, :content

  validates :title,       :presence => true

  validates :user_id,     :presence => true
  validates :project_id,  :presence => true
end
