# coding: utf-8
#
# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  daily_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Comment do
  before :each do
    group = create(:group)
    @user = create(:user_student, group: group)
    @daily = create(:daily, user: @user)
  end

  it "is valid with content, daily_id and user_id" do
    #直接构造comment会失败，因为构造user会创建一个group，构造daily又会创建一个group
    #两个group相同，构造失败，因此需要手动构造comment
    #comment = build(:comment)

    comment = build(:comment, daily: @daily, user: @user)
    expect(comment).to be_valid
  end

  it "is invalid without content" do
    comment = build(:comment, content: nil, daily: @daily, user: @user)
    expect(comment).to have(1).errors_on(:content)
  end

  it "is invalid without daily_id" do
    comment = build(:comment, daily: nil, user: @user)
    expect(comment).to have(1).errors_on(:daily_id)
  end

  it "is invalid without user_id" do
    comment = build(:comment, daily: @daily, user: nil)
    expect(comment).to have(1).errors_on(:user_id)
  end
end
