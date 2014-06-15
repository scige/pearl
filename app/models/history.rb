# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  category   :integer
#  detail_id  :integer
#  action     :integer
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class History < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  attr_accessible :category, :detail_id, :action

  validates :category,  :presence => true,
                        :numericality => {:only_integer => true}
  validates :detail_id, :presence => true,
                        :numericality => {:only_integer => true}
  validates :action,    :presence => true,
                        :numericality => {:only_integer => true}

  validates :user_id,   :presence => true
  validates :group_id,  :presence => true
end
