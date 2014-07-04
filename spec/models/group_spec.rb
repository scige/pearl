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

require 'spec_helper'

describe Group do
  it "is valid with name" do
    group = build(:group)
    expect(group).to be_valid
  end

  it "is invalid without name" do
    group = build(:group, name: nil)
    expect(group).to have(1).errors_on(:name)
  end

  it "is invalid with a duplicate name" do
    create(:group, name: "aliyun")
    group = build(:group, name: "aliyun")
    expect(group).to have(1).errors_on(:name)
  end
end
