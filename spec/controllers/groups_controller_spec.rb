require 'spec_helper'

describe GroupsController do

  describe "Post #create" do
    context "with valid attributes" do
      it "has no group, create a root group" do
        @group = build(:group)
        @user = create(:user_admin, :group=>nil)
        sign_in :user, @user

        expect{
          post :create, :group=>attributes_for(:group)
        }.to change(Group, :count).by(1)
        @user.reload
        expect(@user.group.name).to eq @group.name
      end

      it "has a group, create a subgroup" do
        @group = create(:group)
        @user = create(:user_admin, :group=>@group)
        sign_in :user, @user
        @group_search = build(:group)

        expect{
          post :create, :group=>attributes_for(:group_search)
        }.to change(Group, :count).by(1)
        @user.reload
        expect(@user.group.children.size).to eq 1
      end
    end
  end

end
