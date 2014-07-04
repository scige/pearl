# == Schema Information
#
# Table name: patents
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  agency     :string(255)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Project do
  pending "add some examples to (or delete) #{__FILE__}"
end
