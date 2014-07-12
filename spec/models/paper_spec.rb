# == Schema Information
#
# Table name: papers
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  magazine   :string(255)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Paper do
  it "is valid with a title, a status and a user_id" do
    paper = build(:paper)
    expect(paper).to be_valid
  end

  it "is invalid without a title" do
    paper = build(:paper, title: nil)
    expect(paper).to have(1).errors_on(:title)
  end

  it "is invalid without a status" do
    paper = build(:paper, status: nil)
    expect(paper).to have(2).errors_on(:status)
  end

  it "is invalid when the status is not integer" do
    paper = build(:paper, status: "ok")
    expect(paper).to have(1).errors_on(:status)
  end

  it "is invalid without a user_id" do
    paper = build(:paper, user: nil)
    expect(paper).to have(1).errors_on(:user_id)
  end
end
