# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  document_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Review do
  before :each do
    @user = create(:user_student)
    @thesis = create(:thesis, :user=>@user)
    @document = create(:document, :user=>@user, :thesis=>@thesis, :category=>Setting.documents.category_thesis)
  end

  it "is valid with content, document_id and user_id" do
    #直接构造review会失败，因为构造user会创建一个group，构造document又会创建一个group
    #两个group相同，构造失败，因此需要手动构造review
    #review = build(:review)

    review = build(:review, document: @document, user: @user)
    expect(review).to be_valid
  end

  it "is invalid without content" do
    review = build(:review, content: nil, document: @document, user: @user)
    expect(review).to have(1).errors_on(:content)
  end

  it "is invalid without document_id" do
    review = build(:review, document: nil, user: @user)
    expect(review).to have(1).errors_on(:document_id)
  end

  it "is invalid without user_id" do
    review = build(:review, document: @document, user: nil)
    expect(review).to have(1).errors_on(:user_id)
  end
end
