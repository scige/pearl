# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  document_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Review < ActiveRecord::Base
  belongs_to :document
  belongs_to :user

  attr_accessible :content

  validates :content,     :presence => true

  validates :document_id, :presence => true
  validates :user_id,     :presence => true
end
