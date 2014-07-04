# coding: utf-8

require 'spec_helper'

feature "Home" do
  feature "index page" do
    scenario "User not login" do
      visit root_path
      expect(page).to have_content('知蛛网')
    end
  end
end
