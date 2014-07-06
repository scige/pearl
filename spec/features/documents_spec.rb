# coding: utf-8

require 'spec_helper'

feature "Documents Management" do

  feature "visit documents index page" do
    scenario "all users have ability" do
      user = create(:user_student)
      login(user)

      thesis = create(:thesis, :user=>user)
      document = create(:document, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)
      document2 = create(:document_2, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)
      document3 = create(:document_3, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link thesis.title
      click_link "文档"

      within ".main" do
        expect(page).to have_link(document.title)
        expect(page).to have_link(document2.title)
        expect(page).to have_link(document3.title)
        expect(page).to have_link("新建文档")
      end
    end
  end

  feature "create a new document" do
    scenario "all users have ability" do
      user = create(:user_student)
      login(user)

      thesis = create(:thesis, :user=>user)
      document = build(:document, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link thesis.title
      click_link "文档"

      expect{
        click_link "新建文档"
        fill_in 'document_title', :with=>document.title
        fill_in 'document_content', :with=>document.content
        click_button "保存"
      }.to change(Document, :count).by(1)

      within ".main" do
        expect(page).to have_link(document.title)
        expect(page).to have_content(document.title)
        expect(page).to have_content(document.content)
      end
    end
  end

  feature "edit and delete a document" do
    scenario "teachers have ability" do
      user = create(:user_teacher)
      login(user)

      thesis = create(:thesis, :user=>user)
      document = create(:document, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link thesis.title
      click_link "文档"
      click_link document.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "author student has ability" do
      user = create(:user_student)
      login(user)

      thesis = create(:thesis, :user=>user)
      document = create(:document, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link thesis.title
      click_link "文档"
      click_link document.title

      within ".main" do
        expect(page).to have_link("编辑")
        expect(page).to have_link("删除")
      end
    end

    scenario "other students have no ability" do
      group = create(:group)
      user = create(:user_student, :group=>group)
      thesis = create(:thesis, :user=>user)
      document = create(:document, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)

      user2 = create(:user_student_2, :group=>group)
      login(user2)

      visit root_path
      within ".sidebar" do
        click_link '科研'
      end

      click_link '团队论文'
      click_link thesis.title
      click_link "文档"
      click_link document.title

      within ".main" do
        expect(page).not_to have_link("编辑")
        expect(page).not_to have_link("删除")
      end
    end
  end

  feature "comment a document and delete it" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

end
