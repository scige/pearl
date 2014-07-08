# coding: utf-8

require 'spec_helper'

feature "Projects Management" do

  feature "show all projects in my group" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      project = create(:project, :user=>user)
      project2 = create(:project_2, :user=>user)
      project3 = create(:project_3, :user=>user, :status=>Setting.projects.status_finish)

      visit root_path
      within ".sidebar" do
        click_link '项目'
      end

      within ".main" do
        expect(page).to have_link(project.title)
        expect(page).to have_link(project2.title)
        expect(page).not_to have_link(project3.title)
      end
    end
  end

  feature "visit a project's page" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      project = create(:project, :user=>user)

      visit root_path
      within ".sidebar" do
        click_link '项目'
      end

      click_link project.title

      within ".main" do
        expect(page).to have_link("主页")
        expect(page).to have_link("文档")
        expect(page).to have_link("文件")
        expect(page).to have_link("任务")
        expect(page).to have_link("回顾")

        expect(page).to have_content(project.user.name)
        expect(page).to have_content(project.title)
        expect(page).to have_content(project.source)

        expect(page).to have_link("新建文档")
      end
    end
  end

  feature "create a new project" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '项目'
      end

      expect(page).to have_content('项目管理')
      expect(page).to have_link('新建项目')

      project = build(:project, :user=>user)
      expect{
        click_link '新建项目'
        fill_in 'project_title', :with=>project.title
        select  user.name, :from=>'project_user_id'
        select  '纵向', :from=>'project_category'
        fill_in 'project_source', :with=>project.source
        fill_in 'project_begin_at', :with=>project.begin_at
        fill_in 'project_end_at', :with=>project.end_at
        select  '申报中', :from=>'project_status'
        click_button '保存'
      }.to change(Project, :count).by(1)

      visit root_path
      within ".sidebar" do
        click_link '项目'
      end

      within ".main" do
        expect(page).to have_link(project.title)
        expect(page).to have_link(project.user.name)
      end
    end
  end

  feature "edit and delete a project" do
    scenario "teachers have ability" do
      user = create(:user_teacher)
      project = create(:project, :user=>user)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '项目'
      end

      click_link project.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "author student has ability" do
      user = create(:user_student)
      project = create(:project, :user=>user)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '项目'
      end

      click_link project.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "other students have no ability" do
      group = create(:group)
      user = create(:user_student, :group=>group)
      project = create(:project, :user=>user)

      user2 = create(:user_student_2, :group=>group)
      login(user2)

      visit root_path
      within ".sidebar" do
        click_link '项目'
      end

      click_link project.title

      within ".main" do
        expect(page).not_to have_link("编辑")
        expect(page).not_to have_link("删除")
      end
    end
  end

end
