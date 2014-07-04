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

require 'spec_helper'

describe Daily do
  it "is valid with a content, a date and a user_id" do
    daily = build(:daily)
    expect(daily).to be_valid
  end

  it "is invalid without a content" do
    daily = build(:daily, content: nil)
    expect(daily).to have(1).errors_on(:content)
  end

  it "is invalid without a date" do
    daily = build(:daily, date: nil)
    expect(daily).to have(1).errors_on(:date)
  end

  it "is invalid without a user_id" do
    daily = build(:daily, user: nil)
    expect(daily).to have(1).errors_on(:user_id)
  end
end
