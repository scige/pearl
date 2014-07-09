# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  document_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :review, class: Review do
    content       "ding"
    association   :document
    association   :user, factory: :user_student
  end

  factory :review_teacher, class: Review do
    content       "good"
    association   :document
    association   :user, factory: :user_student
  end
end
