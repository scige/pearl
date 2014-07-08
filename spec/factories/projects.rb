# coding: utf-8
#
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

FactoryGirl.define do
  factory :project, class: Project do
    title         "三维模型检索"
    category      Setting.projects.category_vertical
    source        "国家自然科学基金"
    begin_at      "2014-01-01"
    end_at        "2016-01-01"
    status        Setting.projects.status_applying
    association   :user, factory: :user_student
  end

  factory :project_2, class: Project do
    title         "图像检索"
    category      Setting.projects.category_vertical
    source        "国家自然科学基金"
    begin_at      "2014-01-01"
    end_at        "2016-01-01"
    status        Setting.projects.status_applying
    association   :user, factory: :user_student
  end

  factory :project_3, class: Project do
    title         "文本检索"
    category      Setting.projects.category_vertical
    source        "国家自然科学基金"
    begin_at      "2014-01-01"
    end_at        "2016-01-01"
    status        Setting.projects.status_applying
    association   :user, factory: :user_student
  end
end
