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

FactoryGirl.define do
  factory :history do
    category      Setting.histories.category_daily
    detail_id     nil
    action        Setting.histories.action_create
    association   :user, factory: :user_student
    association   :group
  end
end
