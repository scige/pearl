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

require 'spec_helper'

describe Project do
  pending "add some examples to (or delete) #{__FILE__}"
end