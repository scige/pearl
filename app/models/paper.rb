# == Schema Information
#
# Table name: papers
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  magazine   :string(255)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Paper < ActiveRecord::Base
  has_many :documents
  belongs_to :user

  attr_accessible :title, :magazine, :status

  validates :title,     :presence => true
  validates :status,    :presence => true,
                        :numericality => {:only_integer => true}

  validates :user_id,   :presence => true
end
