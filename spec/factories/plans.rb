# coding: utf-8
#
# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  note       :text
#  begin_at   :datetime
#  end_at     :datetime
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :plan, class: Plan do
    title         "买东西"
    note          "nothing"
    begin_at      "2014-01-01"
    end_at        "2016-01-01"
    status        Setting.plans.status_active
    association   :user, factory: :user_student
  end

  factory :plan_2, class: Plan do
    title         "写论文"
    note          "nothing"
    begin_at      "2014-01-01"
    end_at        "2016-01-01"
    status        Setting.plans.status_active
    association   :user, factory: :user_student
  end

  factory :plan_3, class: Plan do
    title         "打羽毛球"
    note          "nothing"
    begin_at      "2014-01-01"
    end_at        "2016-01-01"
    status        Setting.plans.status_active
    association   :user, factory: :user_student
  end
end
