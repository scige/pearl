require 'spec_helper'

describe "dailies/index" do
  before(:each) do
    assign(:dailies, [
      stub_model(Daily,
        :content => "MyText",
        :user => nil
      ),
      stub_model(Daily,
        :content => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of dailies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
