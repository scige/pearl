# coding: utf-8

require 'spec_helper'

feature "Write Comments" do

  feature "comment a daily" do
    scenario "student comment" do
      user = create(:user_student)
      login(user)

      daily = create(:daily, :user=>user)

      expect{
        visit daily_path(daily)

        fill_in 'comment_content', :with=>"great"
        click_button '提交'
      }.to change(Comment, :count).by(1)

      expect(page).to have_content("1 条评论")
      expect(page).to have_content("great")
      expect(page).to have_link(user.name)
      expect(page).to have_link("删除")
    end

    scenario "teacher comment" do
      group = create(:group)
      user_student = create(:user_student, :group=>group)
      user_teacher = create(:user_teacher, :group=>group)
      login(user_teacher)

      daily = create(:daily, :user=>user_student)

      expect{
        visit daily_path(daily)

        fill_in 'comment_content', :with=>"great"
        click_button '提交'
      }.to change(Comment, :count).by(1)

      expect(page).to have_content("1 条评论")
      expect(page).to have_content("great")
      expect(page).to have_link(user_teacher.name)
      expect(page).to have_link("删除")
    end
  end

  feature "delete a comment" do
    scenario "a student can delete his comment" do
      user = create(:user_student)
      login(user)

      daily = create(:daily, :user=>user)
      comment = create(:comment, :daily=>daily, :user=>user)

      expect{
        visit daily_path(daily)

        click_link '删除'
      }.to change(Comment, :count).by(-1)

      expect(page).to have_content("0 条评论")
      expect(page).not_to have_content(comment.content)
    end

    scenario "a student can't delete others' comments" do
      group = create(:group)
      user  = create(:user_student, :group=>group)
      user2 = create(:user_student_2, :group=>group)
      login(user)

      daily = create(:daily, :user=>user)
      comment = create(:comment, :daily=>daily, :user=>user2)

      visit daily_path(daily)

      expect(page).to have_content("1 条评论")
      expect(page).to have_link(user2.name)
      expect(page).not_to have_link("删除")
    end
  end

end
