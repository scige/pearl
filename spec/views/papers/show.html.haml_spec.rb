require 'spec_helper'

describe "papers/show" do
  before(:each) do
    @paper = assign(:paper, stub_model(Paper,
      :title => "Title",
      :magazine => "Magazine",
      :status => 1,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Magazine/)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
