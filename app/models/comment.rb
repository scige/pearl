# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  daily_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :daily
  belongs_to :user

  attr_accessible :content

  validates :content,   :presence => true

  validates :daily_id,  :presence => true
  validates :user_id,   :presence => true
end
