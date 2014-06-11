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

require 'spec_helper'

describe History do
  pending "add some examples to (or delete) #{__FILE__}"
end
