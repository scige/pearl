# coding: utf-8
#
# == Schema Information
#
# Table name: papers
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  magazine   :string(255)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :paper, class: Paper do
    title         "三维模型检索"
    magazine      "计算机学报"
    status        Setting.papers.status_accept
    association   :user, factory: :user_student
  end

  factory :paper_2, class: Paper do
    title         "图像检索"
    magazine      "计算机学报"
    status        Setting.papers.status_accept
    association   :user, factory: :user_student
  end

  factory :paper_3, class: Paper do
    title         "文本检索"
    magazine      "计算机学报"
    status        Setting.papers.status_accept
    association   :user, factory: :user_student
  end
end
