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

  feature "visit my group today daily" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  feature "visit my subgroup today daily" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

end
