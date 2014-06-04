require 'spec_helper'

describe "dailies/edit" do
  before(:each) do
    @daily = assign(:daily, stub_model(Daily,
      :content => "MyText",
      :user => nil
    ))
  end

  it "renders the edit daily form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", daily_path(@daily), "post" do
      assert_select "textarea#daily_content[name=?]", "daily[content]"
      assert_select "input#daily_user[name=?]", "daily[user]"
    end
  end
end
