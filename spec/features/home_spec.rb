# coding: utf-8

require 'spec_helper'

feature "Visit homepage" do

  feature "normal elements in view" do
    scenario "user not sign_in" do
      visit root_path
      within ".navbar" do
        expect(page).to have_content('知蛛网')
        expect(page).to have_link('注册')
        expect(page).to have_link('登录')
      end
      expect(page).to have_link('动态')
      expect(page).to have_link('日报')
      expect(page).to have_link('计划')
      expect(page).to have_link('科研')
      expect(page).to have_link('项目')
      expect(page).to have_link('论文')
      expect(page).to have_link('专利')
      expect(page).to have_link('成员')
      expect(page).to have_link('团队')
      expect(page).to have_link('资源')
    end

    scenario "user sign_in" do
      user = create(:user_student)
      login(user)

      #登录后会自动跳转到root_page
      within ".navbar" do
        expect(page).to have_content('知蛛网')
        expect(page).to have_content('欢迎您')
        expect(page).not_to have_link('注册')
        #expect(page).not_to have_link('登录')
      end
      expect(page).to have_link('动态')
      expect(page).to have_link('日报')
      expect(page).to have_link('计划')
      expect(page).to have_link('科研')
      expect(page).to have_link('项目')
      expect(page).to have_link('论文')
      expect(page).to have_link('专利')
      expect(page).to have_link('成员')
      expect(page).to have_link('团队')
      expect(page).to have_link('资源')
      expect(page).to have_content('公告')
    end
  end

  feature "trends display" do
    scenario "user not sign_in" do
      pending "add some examples to (or delete) #{__FILE__}"
    end

    scenario "user sign_in" do
      pending "add some examples to (or delete) #{__FILE__}"
    end
  end
end
