# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  daily_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :comment, class: Comment do
    content       "ding"
    association   :daily
    association   :user, factory: :user_student
  end

  factory :comment_teacher, class: Comment do
    content       "good"
    association   :daily
    association   :user, factory: :user_teacher
  end
end
