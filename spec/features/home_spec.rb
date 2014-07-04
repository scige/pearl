# coding: utf-8

require 'spec_helper'

describe "Home" do
  describe "index page" do
    it "should have the content '知蛛网'" do
      visit root_path
      page.should have_content('知网')
    end
  end
end
