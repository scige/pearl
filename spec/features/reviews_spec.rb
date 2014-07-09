# coding: utf-8

require 'spec_helper'

feature "Write Reviews" do

  feature "review a document" do
    scenario "student review" do
      user = create(:user_student)
      login(user)

      thesis = create(:thesis, :user=>user)
      document = create(:document, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)

      expect{
        visit thesis_document_path(thesis, document)

        fill_in 'review_content', :with=>"great"
        click_button '提交'
      }.to change(Review, :count).by(1)

      expect(page).to have_content("great")
      expect(page).to have_link(user.name)
      expect(page).to have_link("删除")
    end

    scenario "teacher review" do
      group = create(:group)
      user_student = create(:user_student, :group=>group)
      user_teacher = create(:user_teacher, :group=>group)
      login(user_teacher)

      thesis = create(:thesis, :user=>user_student)
      document = create(:document, :user=>user_student, :thesis=>thesis, :category=>Setting.documents.category_thesis)

      expect{
        visit thesis_document_path(thesis, document)

        fill_in 'review_content', :with=>"great"
        click_button '提交'
      }.to change(Review, :count).by(1)

      expect(page).to have_content("great")
      expect(page).to have_link(user_teacher.name)
      expect(page).to have_link("删除")
    end
  end

  feature "delete a review" do
    scenario "a student can delete his review" do
      user = create(:user_student)
      login(user)

      thesis = create(:thesis, :user=>user)
      document = create(:document, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)
      review = create(:review, :document=>document, :user=>user)

      expect{
        visit thesis_document_path(thesis, document)

        within ".comments" do
          click_link '删除'
        end
      }.to change(Review, :count).by(-1)

      within ".comments" do
        expect(page).not_to have_content(review.content)
      end
    end

    scenario "a student can't delete others' reviews" do
      group = create(:group)
      user  = create(:user_student, :group=>group)
      user2 = create(:user_student_2, :group=>group)
      login(user)

      thesis = create(:thesis, :user=>user)
      document = create(:document, :user=>user, :thesis=>thesis, :category=>Setting.documents.category_thesis)
      review = create(:review, :document=>document, :user=>user2)

      visit thesis_document_path(thesis, document)

      within ".comments" do
        expect(page).to have_link(user2.name)
        expect(page).not_to have_link("删除")
      end
    end
  end

end
