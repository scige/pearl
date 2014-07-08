# coding: utf-8

require 'spec_helper'

feature "Visit Homepage" do

  feature "normal elements in view" do
    scenario "user not sign_in" do
      visit root_path
      within ".navbar" do
        expect(page).to have_content('科研圈')
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
        expect(page).to have_content('科研圈')
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

  feature "an user selects the group" do
    scenario "an admin sign_in, hasn't created a group" do
      user = create(:user_admin, :group=>nil)
      login(user)

      visit root_path

      within ".main" do
        expect(page).to have_link("创建团队")
      end
    end

    scenario "an admin sign_in, has created a group" do
      user = create(:user_admin)
      login(user)

      visit root_path

      within ".main" do
        expect(page).not_to have_link("创建团队")
      end
    end

    scenario "a teacher sign_in, hasn't selected a group" do
      user = create(:user_teacher, :group=>nil)
      login(user)

      visit root_path

      within ".main" do
        expect(page).to have_content("选择团队")
      end
    end

    scenario "a teacher sign_in, has selected a group" do
      user = create(:user_teacher)
      login(user)

      visit root_path

      within ".main" do
        expect(page).not_to have_content("选择团队")
      end
    end

    scenario "a student sign_in, hasn't selected a group" do
      user = create(:user_student, :group=>nil)
      login(user)

      visit root_path

      within ".main" do
        expect(page).to have_content("选择团队")
      end
    end

    scenario "a student sign_in, has selected a group" do
      user = create(:user_student)
      login(user)

      visit root_path

      within ".main" do
        expect(page).not_to have_content("选择团队")
      end
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
