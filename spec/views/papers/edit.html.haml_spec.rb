require 'spec_helper'

describe "papers/edit" do
  before(:each) do
    @paper = assign(:paper, stub_model(Paper,
      :title => "MyString",
      :magazine => "MyString",
      :status => 1,
      :user => nil
    ))
  end

  it "renders the edit paper form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", paper_path(@paper), "post" do
      assert_select "input#paper_title[name=?]", "paper[title]"
      assert_select "input#paper_magazine[name=?]", "paper[magazine]"
      assert_select "input#paper_status[name=?]", "paper[status]"
      assert_select "input#paper_user[name=?]", "paper[user]"
    end
  end
end
