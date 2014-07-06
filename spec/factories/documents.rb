# coding: utf-8
#
# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  paper_id   :integer
#  patent_id  :integer
#  thesis_id  :integer
#

FactoryGirl.define do
  factory :document, class: Document do
    title         "桃园结义"
    content       "刘备，关羽，张飞在桃花园结为异性兄弟。"
    association   :user, factory: :user_student
  end

  factory :document_2, class: Document do
    title         "三顾茅庐"
    content       "刘备三顾草庐之中，请诸葛亮出山。"
    association   :user, factory: :user_student
  end

  factory :document_3, class: Document do
    title         "赤壁大战"
    content       "孙刘联军打败曹操80万大军。"
    association   :user, factory: :user_student
  end
end
