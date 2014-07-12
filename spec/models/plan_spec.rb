# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  note       :text
#  begin_at   :datetime
#  end_at     :datetime
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Plan do
  it "is valid with a title, a status and a user_id" do
    plan = build(:plan)
    expect(plan).to be_valid
  end

  it "is invalid without a title" do
    plan = build(:plan, title: nil)
    expect(plan).to have(1).errors_on(:title)
  end

  it "is invalid without a status" do
    plan = build(:plan, status: nil)
    expect(plan).to have(2).errors_on(:status)
  end

  it "is invalid when the status is not integer" do
    plan = build(:plan, status: "ok")
    expect(plan).to have(1).errors_on(:status)
  end

  it "is invalid without a user_id" do
    plan = build(:plan, user: nil)
    expect(plan).to have(1).errors_on(:user_id)
  end
end
