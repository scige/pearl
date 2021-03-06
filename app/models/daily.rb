# == Schema Information
#
# Table name: dailies
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  date       :datetime
#

class Daily < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  attr_accessible :content, :date

  validates :content,   :presence => true
  validates :date,      :presence => true

  validates :user_id,   :presence => true
end
