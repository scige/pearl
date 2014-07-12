# == Schema Information
#
# Table name: theses
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  abstract   :text
#  keywords   :string(255)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Thesis do
  it "is valid with a title, a status and a user_id" do
    thesis = build(:thesis)
    expect(thesis).to be_valid
  end

  it "is invalid without a title" do
    thesis = build(:thesis, title: nil)
    expect(thesis).to have(1).errors_on(:title)
  end

  it "is invalid without a status" do
    thesis = build(:thesis, status: nil)
    expect(thesis).to have(2).errors_on(:status)
  end

  it "is invalid when the status is not integer" do
    thesis = build(:thesis, status: "ok")
    expect(thesis).to have(1).errors_on(:status)
  end

  it "is invalid without a user_id" do
    thesis = build(:thesis, user: nil)
    expect(thesis).to have(1).errors_on(:user_id)
  end
end
