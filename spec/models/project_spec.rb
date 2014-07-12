# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  category   :integer
#  source     :string(255)
#  begin_at   :datetime
#  end_at     :datetime
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Project do
  it "is valid with a title, a status and a user_id" do
    project = build(:project)
    expect(project).to be_valid
  end

  it "is invalid without a title" do
    project = build(:project, title: nil)
    expect(project).to have(1).errors_on(:title)
  end

  it "is invalid without a status" do
    project = build(:project, status: nil)
    expect(project).to have(2).errors_on(:status)
  end

  it "is invalid when the status is not integer" do
    project = build(:project, status: "ok")
    expect(project).to have(1).errors_on(:status)
  end

  it "is invalid without a user_id" do
    project = build(:project, user: nil)
    expect(project).to have(1).errors_on(:user_id)
  end
end
