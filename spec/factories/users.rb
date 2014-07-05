# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  group_id               :integer
#  name                   :string(255)
#  identity               :integer
#  phone                  :string(255)
#  grade                  :integer
#

FactoryGirl.define do
  factory :user_admin, class: User do
    email         "pan@163.com"
    password      "123ert678"
    name          ""
    identity      Setting.users.identity_admin
    phone         13888888888
    association   :group
  end

  factory :user_teacher, class: User do
    email         "yang@163.com"
    password      "123ert678"
    name          "yang"
    identity      Setting.users.identity_teacher
    phone         13666666666
    association   :group
  end

  factory :user_student, class: User do
    email         "zhang@163.com"
    password      "123ert678"
    name          "zhang"
    identity      Setting.users.identity_student
    phone         13999999999
    grade         2013
    association   :group
  end

  factory :user_student_2, class: User do
    email         "wang@163.com"
    password      "123ert678"
    name          "wang"
    identity      Setting.users.identity_student
    phone         13777777777
    grade         2012
    association   :group
  end
end
