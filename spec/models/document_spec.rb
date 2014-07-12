# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  paper_id   :integer
#  patent_id  :integer
#  thesis_id  :integer
#

require 'spec_helper'

describe Document do
  it "is valid with a title, a category and a user_id" do
    document = build(:document, :category=>Setting.documents.category_thesis)
    expect(document).to be_valid
  end

  it "is invalid without a title" do
    document = build(:document, title: nil)
    expect(document).to have(1).errors_on(:title)
  end

  it "is invalid without a category" do
    document = build(:document, category: nil)
    expect(document).to have(2).errors_on(:category)
  end

  it "is invalid when the category is not integer" do
    document = build(:document, category: "ok")
    expect(document).to have(1).errors_on(:category)
  end

  it "is invalid without a user_id" do
    document = build(:document, user: nil)
    expect(document).to have(1).errors_on(:user_id)
  end
end
