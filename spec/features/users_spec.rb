# coding: utf-8

require 'spec_helper'

feature "User Management" do

  feature "edit and delete users" do
    scenario "admins have ability" do
      user = create(:user_admin)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '成员'
      end

      within ".main" do
        expect(page).to have_link('编辑')
        expect(page).to have_link('删除')
      end
    end

    scenario "teachers have ability" do
      user = create(:user_teacher)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '成员'
      end

      within ".main" do
        expect(page).to have_link('编辑')
        expect(page).to have_link('删除')
      end
    end

    scenario "students don't have ability" do
      user = create(:user_student)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '成员'
      end

      within ".main" do
        expect(page).not_to have_link('编辑')
        expect(page).not_to have_link('删除')
      end
    end
  end

end
