require 'spec_helper'

describe "groups/show" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :name => "Name",
      :university => "University",
      :school => "School"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/University/)
    rendered.should match(/School/)
  end
end
