# coding: utf-8

require 'spec_helper'

feature "Group Management" do

  feature "create, edit and delete groups" do
    scenario "admins have ability" do
      group = create(:group)
      subgroup = create(:group_search, :parent_id=>group.id)
      user = create(:user_admin, :group=>group)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '团队'
      end

      within ".main" do
        expect(page).to have_link('编辑')
        expect(page).to have_link('删除')
        expect(page).to have_link('新建小组')
      end
    end

    scenario "teachers don't have ability" do
      user = create(:user_teacher)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '团队'
      end

      within ".main" do
        expect(page).not_to have_link('编辑')
        expect(page).not_to have_link('删除')
        expect(page).not_to have_link('新建小组')
      end
    end

    scenario "students don't have ability" do
      user = create(:user_student)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '团队'
      end

      within ".main" do
        expect(page).not_to have_link('编辑')
        expect(page).not_to have_link('删除')
        expect(page).not_to have_link('新建小组')
      end
    end
  end

end
