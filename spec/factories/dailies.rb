# == Schema Information
#
# Table name: dailies
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  date       :datetime
#

FactoryGirl.define do
  factory :daily do
    content       "nice day"
    date          "2014-07-04"
    association   :user, factory: :user_student
  end
end
