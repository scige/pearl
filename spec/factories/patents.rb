# coding: utf-8
#
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

FactoryGirl.define do
  factory :patent, class: Patent do
    title         "三维模型检索"
    agency        "泛华伟业"
    status        Setting.patents.status_writing
    association   :user, factory: :user_student
  end

  factory :patent_2, class: Patent do
    title         "图像检索"
    agency        "泛华伟业"
    status        Setting.patents.status_writing
    association   :user, factory: :user_student
  end

  factory :patent_3, class: Patent do
    title         "文本检索"
    agency        "泛华伟业"
    status        Setting.patents.status_writing
    association   :user, factory: :user_student
  end
end
