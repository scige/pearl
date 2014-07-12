# coding: utf-8

require 'spec_helper'

feature "Visit Homepage" do

  feature "dailies trends display" do
    background do
      @group        = create(:group)
      @group_2      = create(:group_2)
      @subgroup_1   = create(:group_search)
      @subgroup_1.move_to_child_of(@group)
      @subgroup_2   = create(:group_mining)
      @subgroup_2.move_to_child_of(@group)

      @user_admin     = create(:user_admin, :group=>@group)
      @user_teacher_1 = create(:user_teacher, :group=>@subgroup_1)
      @user_teacher_2 = create(:user_teacher_2, :group=>@subgroup_2)
      @user_teacher_3 = create(:user_teacher_3, :group=>@group)
      @user_student_1 = create(:user_student, :group=>@subgroup_1)
      @user_student_2 = create(:user_student_2, :group=>@subgroup_2)
      @user_student_3 = create(:user_student_3, :group=>@group_2)

      @daily_1   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily one", :user=>@user_student_1)
      @daily_2   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily two", :user=>@user_student_2)
      @daily_3   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily three", :user=>@user_student_3)

      @history_1 = create(:history, :category=>Setting.histories.category_daily, :detail_id=>@daily_1.id, :user=>@daily_1.user, :group=>@group)
      @history_2 = create(:history, :category=>Setting.histories.category_daily, :detail_id=>@daily_2.id, :user=>@daily_2.user, :group=>@group)
      @history_3 = create(:history, :category=>Setting.histories.category_daily, :detail_id=>@daily_3.id, :user=>@daily_3.user, :group=>@group_2)
    end

    scenario "an user not sign_in, can't see anything" do
      visit root_path
      expect(page).not_to have_content("日报动态")
      expect(page).not_to have_link(@daily_1.user.name)
      expect(page).not_to have_link(@daily_2.user.name)
      expect(page).not_to have_link(@daily_3.user.name)
    end

    scenario "a student can see his dailies trends only" do
      login(@user_student_1)
      expect(page).to have_content("日报动态")
      expect(page).to have_link(@daily_1.user.name)
      expect(page).not_to have_link(@daily_2.user.name)
      expect(page).not_to have_link(@daily_3.user.name)
    end

    scenario "a subgroup teacher can see subgroup dailies trends" do
      login(@user_teacher_1)
      expect(page).to have_content("日报动态")
      expect(page).to have_link(@daily_1.user.name)
      expect(page).not_to have_link(@daily_2.user.name)
      expect(page).not_to have_link(@daily_3.user.name)

      click_link '退出登录'

      login(@user_teacher_2)
      expect(page).to have_content("日报动态")
      expect(page).not_to have_link(@daily_1.user.name)
      expect(page).to have_link(@daily_2.user.name)
      expect(page).not_to have_link(@daily_3.user.name)
    end

    scenario "a group teacher can't see subgroup dailies trends" do
      login(@user_teacher_3)
      expect(page).not_to have_content("日报动态")
      expect(page).not_to have_link(@daily_1.user.name)
      expect(page).not_to have_link(@daily_2.user.name)
      expect(page).not_to have_link(@daily_3.user.name)
    end

    scenario "an admin can see all group dailies trends" do
      login(@user_admin)
      expect(page).to have_content("日报动态")
      expect(page).to have_link(@daily_1.user.name)
      expect(page).to have_link(@daily_2.user.name)
      expect(page).not_to have_link(@daily_3.user.name)
    end
  end

  feature "comments trends display" do
    background do
      @group        = create(:group)
      @subgroup_1   = create(:group_search)
      @subgroup_1.move_to_child_of(@group)
      @subgroup_2   = create(:group_mining)
      @subgroup_2.move_to_child_of(@group)

      @user_admin     = create(:user_admin, :group=>@group)
      @user_teacher_1 = create(:user_teacher, :group=>@subgroup_1)
      @user_teacher_2 = create(:user_teacher_2, :group=>@subgroup_2)    #不同组的老师
      @user_teacher_3 = create(:user_teacher_3, :group=>@group)
      @user_student_1 = create(:user_student, :group=>@subgroup_1)
      @user_student_2 = create(:user_student_2, :group=>@subgroup_1)    #同组的学生

      @daily_1   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily one", :user=>@user_student_1)
      @daily_2   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily two", :user=>@user_student_2)

      @comment_1 = create(:comment, :content=>"comment one", :daily=>@daily_1, :user=>@user_student_1)
      @comment_2 = create(:comment, :content=>"comment two", :daily=>@daily_1, :user=>@user_teacher_1)
      @comment_3 = create(:comment, :content=>"comment three", :daily=>@daily_1, :user=>@user_teacher_2)
      @comment_4 = create(:comment, :content=>"comment four", :daily=>@daily_1, :user=>@user_teacher_3)

      @comment_5 = create(:comment, :content=>"comment five", :daily=>@daily_2, :user=>@user_student_1)
      @comment_6 = create(:comment, :content=>"comment six", :daily=>@daily_2, :user=>@user_teacher_1)
      @comment_7 = create(:comment, :content=>"comment seven", :daily=>@daily_2, :user=>@user_teacher_2)
      @comment_8 = create(:comment, :content=>"comment eight", :daily=>@daily_2, :user=>@user_teacher_3)

      @history_1 = create(:history, :category=>Setting.histories.category_daily_comment, :detail_id=>@comment_1.id, :user=>@comment_1.user, :group=>@group)
      @history_2 = create(:history, :category=>Setting.histories.category_daily_comment, :detail_id=>@comment_2.id, :user=>@comment_2.user, :group=>@group)
      @history_3 = create(:history, :category=>Setting.histories.category_daily_comment, :detail_id=>@comment_3.id, :user=>@comment_3.user, :group=>@group)
      @history_4 = create(:history, :category=>Setting.histories.category_daily_comment, :detail_id=>@comment_4.id, :user=>@comment_4.user, :group=>@group)
      @history_5 = create(:history, :category=>Setting.histories.category_daily_comment, :detail_id=>@comment_5.id, :user=>@comment_5.user, :group=>@group)
      @history_6 = create(:history, :category=>Setting.histories.category_daily_comment, :detail_id=>@comment_6.id, :user=>@comment_6.user, :group=>@group)
      @history_7 = create(:history, :category=>Setting.histories.category_daily_comment, :detail_id=>@comment_7.id, :user=>@comment_7.user, :group=>@group)
      @history_8 = create(:history, :category=>Setting.histories.category_daily_comment, :detail_id=>@comment_8.id, :user=>@comment_8.user, :group=>@group)
    end

    scenario "a student can see trends which he comments on others' dailies" do
      login(@user_student_1)
      expect(page).to have_content("日报动态")
      expect(page).to have_link(@comment_5.user.name)
    end

    scenario "a student can see trends which others comment on his dailies" do
      login(@user_student_1)
      expect(page).to have_content("日报动态")
      expect(page).to have_link(@comment_1.user.name)
      expect(page).to have_link(@comment_2.user.name)
      expect(page).to have_link(@comment_3.user.name)
      expect(page).to have_link(@comment_4.user.name)
    end

    scenario "a teacher can see trends which he comments on others' dailies" do
      login(@user_teacher_1)
      expect(page).to have_content("日报动态")
      expect(page).to have_link(@comment_2.user.name)
      expect(page).to have_link(@comment_6.user.name)
    end

    scenario "a subgroup teacher can see trends of comments on subgroup dailies" do
      login(@user_teacher_1)
      expect(page).to have_content("日报动态")
      expect(page).to have_link(@comment_1.user.name)
      expect(page).to have_link(@comment_2.user.name)
      expect(page).to have_link(@comment_3.user.name)
      expect(page).to have_link(@comment_4.user.name)
    end

    scenario "a group teacher can't see trends of comments on subgroup dailies" do
      login(@user_teacher_3)
      expect(page).to have_content("日报动态")
      expect(page).not_to have_link(@comment_1.user.name)
      expect(page).not_to have_link(@comment_2.user.name)
      expect(page).not_to have_link(@comment_3.user.name)
      expect(page).to have_link(@comment_4.user.name)
      expect(page).not_to have_link(@comment_5.user.name)
      expect(page).not_to have_link(@comment_6.user.name)
      expect(page).not_to have_link(@comment_7.user.name)
      expect(page).to have_link(@comment_8.user.name)
    end

    scenario "an admin can see trends of all comments on group dailies" do
      login(@user_admin)
      expect(page).to have_content("日报动态")
      expect(page).to have_link(@comment_1.user.name)
      expect(page).to have_link(@comment_2.user.name)
      expect(page).to have_link(@comment_3.user.name)
      expect(page).to have_link(@comment_4.user.name)
      expect(page).to have_link(@comment_5.user.name)
      expect(page).to have_link(@comment_6.user.name)
      expect(page).to have_link(@comment_7.user.name)
      expect(page).to have_link(@comment_8.user.name)
    end
  end

end
