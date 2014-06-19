# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  category   :integer
#  source     :string(255)
#  begin_at   :datetime
#  end_at     :datetime
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  has_many :documents
  belongs_to :user

  attr_accessible :title, :category, :source, :begin_at, :end_at, :status

  validates :title,     :presence => true
  validates :status,    :presence => true,
                        :numericality => {:only_integer => true}

  validates :user_id,   :presence => true
end
