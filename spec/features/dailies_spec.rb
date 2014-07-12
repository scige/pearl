# coding: utf-8

require 'spec_helper'

feature "Write Dailies" do

  feature "tabbar visibility" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '日报'
      end

      expect(page).not_to have_link('我的日报')
      expect(page).not_to have_link('小组日报')
      expect(page).not_to have_link('团队日报')
    end

    scenario "teacher login" do
      user = create(:user_teacher)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '日报'
      end

      expect(page).to have_link('我的日报')
      expect(page).to have_link('小组日报')
      expect(page).to have_link('团队日报')
    end

    scenario "admin login" do
      user = create(:user_admin)
      login(user)

      visit root_path
      within ".sidebar" do
        click_link '日报'
      end

      expect(page).to have_link('我的日报')
      expect(page).to have_link('小组日报')
      expect(page).to have_link('团队日报')
    end
  end
  
  feature "write and edit my today daily" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      expect{
        visit root_path
        within ".sidebar" do
          click_link '日报'
        end

        fill_in 'daily_content', :with=>"holiday!"
        click_button '发布'
      }.to change(Daily, :count).by(1)

      expect(page).to have_content("按时提交")
      expect(page).to have_content("holiday!")
      expect(page).to have_button("修改")

      expect{
        fill_in 'daily_content', :with=>"work day"
        click_button '修改'
      }.not_to change(Daily, :count)

      expect(page).to have_content("work day")
    end
  end

  feature "write my former daily" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      expect{
        visit "/dailies/my/2014-07-05"

        fill_in 'daily_content', :with=>"holiday!"
        click_button '发布'
      }.to change(Daily, :count).by(1)

      expect(page).to have_content("逾期提交")
      expect(page).to have_content("holiday!")
      expect(page).to have_button("修改")
    end
  end

  feature "write my later daily" do
    scenario "student login" do
      user = create(:user_student)
      login(user)

      expect{
        visit "/dailies/my/#{(Time.now+1.day).strftime("%Y-%m-%d")}"

        fill_in 'daily_content', :with=>"holiday!"
        click_button '发布'
      }.not_to change(Daily, :count)

      expect(page).to have_content("未提交")
      expect(page).not_to have_content("holiday!")
      expect(page).not_to have_button("修改")
    end
  end

  feature "visit my subgroup today daily" do
    background do
      @group        = create(:group)
      @subgroup_1   = create(:group_search)
      @subgroup_1.move_to_child_of(@group)
      @subgroup_2   = create(:group_mining)
      @subgroup_2.move_to_child_of(@group)

      @user_teacher_1 = create(:user_teacher, :group=>@subgroup_1)
      @user_teacher_2 = create(:user_teacher_2, :group=>@group)
      @user_student_1 = create(:user_student, :group=>@subgroup_1)
      @user_student_2 = create(:user_student_2, :group=>@subgroup_2)
      @user_student_3 = create(:user_student_3, :group=>@subgroup_1)

      @daily_1   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily one", :user=>@user_student_1)
      @daily_2   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily two", :user=>@user_student_2)
      #@daily_3   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily three", :user=>@user_student_3)
    end

    scenario "a subgroup teacher can see subgroup dailies" do
      login(@user_teacher_1)
      within ".sidebar" do
        click_link '日报'
      end
      click_link '小组日报'
      expect(page).to have_content("小组日报")
      expect(page).to have_link(@user_student_1.name)
      expect(page).to have_content(@user_student_1.name)
      expect(page).not_to have_link(@user_student_2.name)
      expect(page).not_to have_link(@user_student_3.name)
      expect(page).to have_content(@user_student_3.name)
    end

    scenario "a group teacher can't see subgroup dailies" do
      login(@user_teacher_2)
      within ".sidebar" do
        click_link '日报'
      end
      click_link '小组日报'
      expect(page).to have_content("小组日报")
      expect(page).not_to have_content(@user_student_1.name)
      expect(page).not_to have_content(@user_student_2.name)
      expect(page).not_to have_content(@user_student_3.name)
    end
  end

  feature "visit my group today daily" do
    background do
      @group        = create(:group)
      @subgroup_1   = create(:group_search)
      @subgroup_1.move_to_child_of(@group)
      @subgroup_2   = create(:group_mining)
      @subgroup_2.move_to_child_of(@group)

      @user_teacher_1 = create(:user_teacher, :group=>@subgroup_1)
      @user_teacher_2 = create(:user_teacher_2, :group=>@group)
      @user_student_1 = create(:user_student, :group=>@subgroup_1)
      @user_student_2 = create(:user_student_2, :group=>@subgroup_2)
      @user_student_3 = create(:user_student_3, :group=>@subgroup_1)

      @daily_1   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily one", :user=>@user_student_1)
      @daily_2   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily two", :user=>@user_student_2)
      #@daily_3   = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :content=>"daily three", :user=>@user_student_3)
    end

    scenario "a subgroup teacher can see all group dailies" do
      login(@user_teacher_1)
      within ".sidebar" do
        click_link '日报'
      end
      click_link '团队日报'
      expect(page).to have_link(@user_student_1.name)
      expect(page).to have_content(@user_student_1.name)
      expect(page).to have_link(@user_student_2.name)
      expect(page).to have_content(@user_student_2.name)
      expect(page).not_to have_link(@user_student_3.name)
      expect(page).to have_content(@user_student_3.name)
    end

    scenario "a group teacher can see all group dailies" do
      login(@user_teacher_2)
      within ".sidebar" do
        click_link '日报'
      end
      click_link '团队日报'
      expect(page).to have_link(@user_student_1.name)
      expect(page).to have_content(@user_student_1.name)
      expect(page).to have_link(@user_student_2.name)
      expect(page).to have_content(@user_student_2.name)
      expect(page).not_to have_link(@user_student_3.name)
      expect(page).to have_content(@user_student_3.name)
    end
  end

end
