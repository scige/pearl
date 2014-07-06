# coding: utf-8
#
# == Schema Information
#
# Table name: theses
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  abstract   :text
#  keywords   :string(255)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :thesis, class: Thesis do
    title         "三维模型检索"
    abstract      "基于流形排序算法的三维模型检索"
    keywords      "三维模型检索 流形排序"
    status        Setting.theses.status_proposal
    association   :user, factory: :user_student
  end

  factory :thesis_2, class: Thesis do
    title         "图像检索"
    abstract      "基于流形排序算法的图像检索"
    keywords      "图像检索 流形排序"
    status        Setting.theses.status_proposal
    association   :user, factory: :user_student
  end

  factory :thesis_3, class: Thesis do
    title         "文本检索"
    abstract      "基于流形排序算法的文本检索"
    keywords      "文本检索 流形排序"
    status        Setting.theses.status_proposal
    association   :user, factory: :user_student
  end
end
