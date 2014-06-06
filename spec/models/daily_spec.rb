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

require 'spec_helper'

describe Daily do
  pending "add some examples to (or delete) #{__FILE__}"
end
