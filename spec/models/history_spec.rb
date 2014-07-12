# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  category   :integer
#  detail_id  :integer
#  action     :integer
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe History do
  before :each do
    @group = create(:group)
    @user = create(:user_student, :group=>@group)
    @daily = create(:daily, :user=>@user)
  end

  it "is valid with a category, a detail_id, a action, a user_id and a group_id" do
    history = build(:history, :detail_id=>@daily.id, :user=>@user, :group=>@group)
    expect(history).to be_valid
  end

  it "is invalid without a category" do
    history = build(:history, :category=>nil, :detail_id=>@daily.id, :user=>@user, :group=>@group)
    expect(history).to have(2).errors_on(:category)
  end

  it "is invalid when the category is not integer" do
    history = build(:history, :category=>"ok", :detail_id=>@daily.id, :user=>@user, :group=>@group)
    expect(history).to have(1).errors_on(:category)
  end

  it "is invalid without a detail_id" do
    history = build(:history, :detail_id=>nil, :user=>@user, :group=>@group)
    expect(history).to have(2).errors_on(:detail_id)
  end

  it "is invalid when the detail_id is not integer" do
    history = build(:history, :detail_id=>"ok", :user=>@user, :group=>@group)
    expect(history).to have(1).errors_on(:detail_id)
  end

  it "is invalid without a action" do
    history = build(:history, :action=>nil, :detail_id=>@daily.id, :user=>@user, :group=>@group)
    expect(history).to have(2).errors_on(:action)
  end

  it "is invalid when the action is not integer" do
    history = build(:history, :action=>"ok", :detail_id=>@daily.id, :user=>@user, :group=>@group)
    expect(history).to have(1).errors_on(:action)
  end

  it "is invalid without a user_id" do
    history = build(:history, :detail_id=>@daily.id, :user=>nil, :group=>@group)
    expect(history).to have(1).errors_on(:user_id)
  end

  it "is invalid without a group_id" do
    history = build(:history, :detail_id=>@daily.id, :user=>@user, :group=>nil)
    expect(history).to have(1).errors_on(:group_id)
  end
end
