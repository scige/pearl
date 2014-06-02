require 'spec_helper'

describe "groups/index" do
  before(:each) do
    assign(:groups, [
      stub_model(Group,
        :name => "Name",
        :university => "University",
        :school => "School"
      ),
      stub_model(Group,
        :name => "Name",
        :university => "University",
        :school => "School"
      )
    ])
  end

  it "renders a list of groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "University".to_s, :count => 2
    assert_select "tr>td", :text => "School".to_s, :count => 2
  end
end
