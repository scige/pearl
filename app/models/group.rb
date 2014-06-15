# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  university :string(255)
#  school     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  depth      :integer
#

class Group < ActiveRecord::Base
  has_many :users
  has_many :histories

  acts_as_nested_set

  attr_accessible :name, :school, :university

  validates :name,      :presence => true,
                        :uniqueness => {:case_sensitive => false}
end
