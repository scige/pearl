require 'spec_helper'

describe UsersController do

  describe "Post #select_group" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>nil)
      sign_in :user, @user
    end

    it "assigns the user's group" do
      post :select_group, :user=>{:group_id=>@group.id}
      @user.reload
      expect(@user.group).to eq @group
    end
  end

  describe "Get #edit_profile" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  describe "Post #update_profile" do
    before :each do
      @group = create(:group)
      @teacher = create(:user_teacher, :group=>@group)
      sign_in :user, @teacher

      @student = create(:user_student_2, :group=>@group)
      @group_new = create(:group_2)
    end

    it "changes the user's attributes" do
      new_name = "Jiang"
      post :update_profile, :user=>{:name=>new_name, :group_id=>@group_new.id, :user_id=>@student.id}
      @student.reload
      expect(@student.group).to eq @group_new
      expect(@student.name).to eq new_name
    end
  end

end
