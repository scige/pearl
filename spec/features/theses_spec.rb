# coding: utf-8

require 'spec_helper'

feature "Theses Management" do

  feature "create a new thesis" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      expect(page).to have_content('学位论文管理')
      expect(page).to have_link('我的论文')
      expect(page).to have_link('团队论文')
      expect(page).to have_link('新建论文')

      thesis = build(:thesis, :user=>user)
      expect{
        click_link '新建论文'
        fill_in 'thesis_title', :with=>thesis.title
        fill_in 'thesis_abstract', :with=>thesis.abstract
        fill_in 'thesis_keywords', :with=>thesis.keywords
        select  '开题中', :from=>'thesis_status'
        click_button '保存'
      }.to change(Thesis, :count).by(1)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      within ".main" do
        expect(page).to have_link(thesis.title)
        expect(page).to have_link(user.name)
      end
    end
  end

  feature "show all theses in my group" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      thesis = create(:thesis, :user=>user)
      thesis2 = create(:thesis_2, :user=>user)
      thesis3 = create(:thesis_3, :user=>user)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link '团队论文'

      within ".main" do
        expect(page).to have_link(thesis.title)
        expect(page).to have_link(thesis2.title)
        expect(page).to have_link(thesis3.title)
      end
    end
  end

  feature "visit a thesis's page" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      thesis = create(:thesis, :user=>user)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link thesis.title

      within ".main" do
        expect(page).to have_link("主页")
        expect(page).to have_link("文档")
        expect(page).to have_link("文件")
        expect(page).to have_link("任务")
        expect(page).to have_link("回顾")

        expect(page).to have_content(user.name)
        expect(page).to have_content(thesis.title)
        expect(page).to have_content(thesis.abstract)
        expect(page).to have_content(thesis.keywords)

        expect(page).to have_link("新建文档")
      end
    end
  end

  feature "edit and delete a thesis" do
    scenario "teachers have ability" do
      user = create(:user_teacher)
      thesis = create(:thesis, :user=>user)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link thesis.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "author student has ability" do
      user = create(:user_student)
      thesis = create(:thesis, :user=>user)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link thesis.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "other students have no ability" do
      group = create(:group)
      user = create(:user_student, :group=>group)
      thesis = create(:thesis, :user=>user)

      user2 = create(:user_student_2, :group=>group)
      login(user2)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      within ".main" do
        expect(page).not_to have_link(thesis.title)
      end

      click_link '团队论文'
      click_link thesis.title

      within ".main" do
        expect(page).not_to have_link("编辑")
        expect(page).not_to have_link("删除")
      end
    end
  end

end
