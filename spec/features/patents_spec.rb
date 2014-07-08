# coding: utf-8

require 'spec_helper'

feature "Patents Management" do

  feature "show all patents in my group" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      patent = create(:patent, :user=>user)
      patent2 = create(:patent_2, :user=>user)
      patent3 = create(:patent_3, :user=>user)

      visit root_path
      within ".sidebar" do
        click_link '专利'
      end

      within ".main" do
        expect(page).to have_link(patent.title)
        expect(page).to have_link(patent2.title)
        expect(page).to have_link(patent3.title)
      end
    end
  end

  feature "visit a patent's page" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      patent = create(:patent, :user=>user)

      visit root_path
      within ".sidebar" do
        click_link '专利'
      end

      click_link patent.title

      within ".main" do
        expect(page).to have_link("主页")
        expect(page).to have_link("文档")
        expect(page).to have_link("文件")
        expect(page).to have_link("任务")
        expect(page).to have_link("回顾")

        expect(page).to have_content(patent.user.name)
        expect(page).to have_content(patent.title)
        expect(page).to have_content(patent.agency)

        expect(page).to have_link("新建文档")
      end
    end
  end

  feature "create a new patent" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '专利'
      end

      expect(page).to have_content('专利管理')
      expect(page).to have_link('新建专利')

      patent = build(:patent, :user=>user)
      expect{
        click_link '新建专利'
        fill_in 'patent_title', :with=>patent.title
        select  user.name, :from=>'patent_user_id'
        fill_in 'patent_agency', :with=>patent.agency
        select  '撰写中', :from=>'patent_status'
        click_button '保存'
      }.to change(Patent, :count).by(1)

      visit root_path
      within ".sidebar" do
        click_link '专利'
      end

      within ".main" do
        expect(page).to have_link(patent.title)
        expect(page).to have_link(patent.user.name)
      end
    end
  end

  feature "edit and delete a patent" do
    scenario "teachers have ability" do
      user = create(:user_teacher)
      patent = create(:patent, :user=>user)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '专利'
      end

      click_link patent.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "author student has ability" do
      user = create(:user_student)
      patent = create(:patent, :user=>user)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '专利'
      end

      click_link patent.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "other students have no ability" do
      group = create(:group)
      user = create(:user_student, :group=>group)
      patent = create(:patent, :user=>user)

      user2 = create(:user_student_2, :group=>group)
      login(user2)

      visit root_path
      within ".sidebar" do
        click_link '专利'
      end

      click_link patent.title

      within ".main" do
        expect(page).not_to have_link("编辑")
        expect(page).not_to have_link("删除")
      end
    end
  end

end
