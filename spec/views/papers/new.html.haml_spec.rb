require 'spec_helper'

describe "papers/new" do
  before(:each) do
    assign(:paper, stub_model(Paper,
      :title => "MyString",
      :magazine => "MyString",
      :status => 1,
      :user => nil
    ).as_new_record)
  end

  it "renders new paper form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", papers_path, "post" do
      assert_select "input#paper_title[name=?]", "paper[title]"
      assert_select "input#paper_magazine[name=?]", "paper[magazine]"
      assert_select "input#paper_status[name=?]", "paper[status]"
      assert_select "input#paper_user[name=?]", "paper[user]"
    end
  end
end
