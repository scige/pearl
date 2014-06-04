require 'spec_helper'

describe "dailies/show" do
  before(:each) do
    @daily = assign(:daily, stub_model(Daily,
      :content => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
