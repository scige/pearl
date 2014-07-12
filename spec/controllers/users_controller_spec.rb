require 'spec_helper'

describe UsersController do

  describe "Post #select_group" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>nil)
      sign_in :user, @user
    end

    context "with valid attributes" do
      it "assigns the user's group" do
        post :select_group, :user=>{:group_id=>@group.id}
        @user.reload
        expect(@user.group).to eq @group
      end
    end

    context "with invalid attributes" do
      it "does not assign the user's group_id" do
        expect{
          post :select_group
        }.to raise_error
        @user.reload
        expect(@user.group).to eq nil
      end
    end
  end

  describe "Get #edit_profile" do
    context "user belongs to root group" do
      it "has root group and subgroup" do
        @group = create(:group)
        @group_search = create(:group_search, :parent_id=>@group.id)
        @group_mining = create(:group_mining, :parent_id=>@group.id)
        @user = create(:user_admin, :group=>@group)
        sign_in :user, @user

        get :edit_profile, :id=>@user.id

        expect(assigns(:groups)).to match_array([@group, @group_search, @group_mining])
      end
    end

    context "user belongs to subgroup" do
      it "has root group and subgroup" do
        @group = create(:group)
        @group_search = create(:group_search, :parent_id=>@group.id)
        @group_mining = create(:group_mining, :parent_id=>@group.id)
        @user = create(:user_admin, :group=>@group_search)
        sign_in :user, @user

        get :edit_profile, :id=>@user.id

        expect(assigns(:groups)).to match_array([@group, @group_search, @group_mining])
      end
    end
  end

  describe "Post #update_profile" do
    before :each do
      @group = create(:group)
      @teacher = create(:user_teacher, :group=>@group)
      sign_in :user, @teacher

      @student = create(:user_student_2, :group=>@group)
      @group_new = create(:group_2)

      @old_name = @student.name
      @new_name = "Jiang"
    end

    context "with valid attributes" do
      it "changes the user's attributes" do
        new_name = "Jiang"
        post :update_profile, :user=>{:name=>@new_name, :group_id=>@group_new.id, :user_id=>@student.id}
        @student.reload
        expect(@student.group).to eq @group_new
        expect(@student.name).to eq @new_name
      end
    end

    context "with invalid attributes" do
      it "does not assign the user's group_id" do
        expect{
          post :update_profile, :user=>{:name=>@new_name, :user_id=>@student.id}
        }.to raise_error
        @student.reload
        expect(@student.group).to eq @group
        expect(@student.name).to eq @old_name
      end

      it "does not assign the user's user_id" do
        expect{
          post :update_profile, :user=>{:name=>@new_name, :group_id=>@group_new.id}
        }.to raise_error
        @student.reload
        expect(@student.group).to eq @group
        expect(@student.name).to eq @old_name
      end

      it "does not assign the user's attributes" do
        post :update_profile, :user=>{:group_id=>@group_new.id, :user_id=>@student.id}
        @student.reload
        expect(@student.group).to eq @group_new
        expect(@student.name).to eq @old_name
      end
    end
  end

  describe "Delete #destroy" do
    before :each do
      @group = create(:group)
      @teacher = create(:user_teacher, :group=>@group)
      sign_in :user, @teacher

      @student = create(:user_student_2, :group=>@group)
      @group_new = create(:group_2)
    end

    it "deletes other user" do
      expect{
        delete :destroy, :id=>@student.id
      }.to change(User, :count).by(-1)
    end

    it "deletes myself" do
      expect{
        delete :destroy, :id=>@teacher.id
      }.to change(User, :count).by(-1)
    end
  end

end
