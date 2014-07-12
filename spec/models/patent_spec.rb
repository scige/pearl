# == Schema Information
#
# Table name: patents
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  agency     :string(255)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Project do
  it "is valid with a title, a status and a user_id" do
    patent = build(:patent)
    expect(patent).to be_valid
  end

  it "is invalid without a title" do
    patent = build(:patent, title: nil)
    expect(patent).to have(1).errors_on(:title)
  end

  it "is invalid without a status" do
    patent = build(:patent, status: nil)
    expect(patent).to have(2).errors_on(:status)
  end

  it "is invalid when the status is not integer" do
    patent = build(:patent, status: "ok")
    expect(patent).to have(1).errors_on(:status)
  end

  it "is invalid without a user_id" do
    patent = build(:patent, user: nil)
    expect(patent).to have(1).errors_on(:user_id)
  end
end
