# coding: utf-8

require 'spec_helper'

feature "Papers Management" do

  feature "show all papers in my group" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      paper = create(:paper, :user=>user)
      paper2 = create(:paper_2, :user=>user)
      paper3 = create(:paper_3, :user=>user)

      visit root_path
      within ".sidebar" do
        click_link '论文'
      end

      within ".main" do
        expect(page).to have_link(paper.title)
        expect(page).to have_link(paper2.title)
        expect(page).to have_link(paper3.title)
      end
    end
  end

  feature "visit a paper's page" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      paper = create(:paper, :user=>user)

      visit root_path
      within ".sidebar" do
        click_link '论文'
      end

      click_link paper.title

      within ".main" do
        expect(page).to have_link("主页")
        expect(page).to have_link("文档")
        expect(page).to have_link("文件")
        expect(page).to have_link("任务")
        expect(page).to have_link("回顾")

        expect(page).to have_content(paper.user.name)
        expect(page).to have_content(paper.title)
        expect(page).to have_content(paper.magazine)

        expect(page).to have_link("新建文档")
      end
    end
  end

  feature "create a new paper" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '论文'
      end

      expect(page).to have_content('论文管理')
      expect(page).to have_link('新建论文')

      paper = build(:paper, :user=>user)
      expect{
        click_link '新建论文'
        fill_in 'paper_title', :with=>paper.title
        select  user.name, :from=>'paper_user_id'
        fill_in 'paper_magazine', :with=>paper.magazine
        select  '已录用', :from=>'paper_status'
        click_button '保存'
      }.to change(Paper, :count).by(1)

      visit root_path
      within ".sidebar" do
        click_link '论文'
      end

      within ".main" do
        expect(page).to have_link(paper.title)
        expect(page).to have_link(paper.user.name)
      end
    end
  end

  feature "edit and delete a paper" do
    scenario "teachers have ability" do
      user = create(:user_teacher)
      paper = create(:paper, :user=>user)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '论文'
      end

      click_link paper.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "author student has ability" do
      user = create(:user_student)
      paper = create(:paper, :user=>user)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '论文'
      end

      click_link paper.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "other students have no ability" do
      group = create(:group)
      user = create(:user_student, :group=>group)
      paper = create(:paper, :user=>user)

      user2 = create(:user_student_2, :group=>group)
      login(user2)

      visit root_path
      within ".sidebar" do
        click_link '论文'
      end

      click_link paper.title

      within ".main" do
        expect(page).not_to have_link("编辑")
        expect(page).not_to have_link("删除")
      end
    end
  end

end
