require 'spec_helper'

describe "dailies/new" do
  before(:each) do
    assign(:daily, stub_model(Daily,
      :content => "MyText",
      :user => nil
    ).as_new_record)
  end

  it "renders new daily form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dailies_path, "post" do
      assert_select "textarea#daily_content[name=?]", "daily[content]"
      assert_select "input#daily_user[name=?]", "daily[user]"
    end
  end
end
