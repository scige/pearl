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
end
