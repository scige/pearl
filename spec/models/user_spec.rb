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

require 'spec_helper'

describe User do
  it "is valid with email, password, name and identity" do
    user = build(:user_student)
    expect(user).to be_valid
  end

  it "is invalid without email" do
    user = build(:user_student, email: nil)
    expect(user).to have(1).errors_on(:email)
  end

  it "is invalid without password" do
    user = build(:user_student, password: nil)
    expect(user).to have(1).errors_on(:password)
  end

  it "is invalid without name" do
    user = build(:user_student, name: nil)
    expect(user).to have(1).errors_on(:name)
  end

  it "is invalid without identity" do
    user = build(:user_student, identity: nil)
    expect(user).to have(2).errors_on(:identity)
  end

  it "is invalid with a duplicate email" do
    group = create(:group)
    create(:user_student, email: "mayun@163.com", group: group)
    user = build(:user_student, email: "mayun@163.com", group: group)
    expect(user).to have(1).errors_on(:email)
  end

  it "is valid with a duplicate name" do
    group = create(:group)
    create(:user_student, email: "mayun@163.com", name: "mayun", group: group)
    user = build(:user_student, email: "mayun@sohu.com", name: "mayun", group: group)
    expect(user).to be_valid
  end

  it "is invalid when the identity is not integer" do
    user = build(:user_student, identity: "student")
    expect(user).to have(1).errors_on(:identity)
  end

  describe "check admin role" do
    it "is admin when the identity is admin" do
      user = build(:user_admin)
      expect(user.admin?).to eq(true)
    end

    it "is not admin when the identity is teacher" do
      user = build(:user_teacher)
      expect(user.admin?).to eq(false)
    end

    it "is not admin when the identity is student" do
      user = build(:user_student)
      expect(user.admin?).to eq(false)
    end
  end
end
