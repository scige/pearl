# coding: utf-8
#
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


FactoryGirl.define do
  factory :group, class: Group do
    name          "图形所"
    university    "清华大学"
    school        "软件学院"
  end

  factory :group_2, class: Group do
    name          "人工智能组"
    university    "清华大学"
    school        "自动化系"
  end
end
