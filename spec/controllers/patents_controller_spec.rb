require 'spec_helper'

describe PatentsController do

  describe "Get #index" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user

      @group2 = create(:group_2)
      @user2 = create(:user_student_2, :group=>@group2)
    end

    it "populates an array of patents belong to user's group" do
      patent = create(:patent, :user=>@user)
      patent2 = create(:patent_2, :user=>@user)
      patent3 = create(:patent_3, :user=>@user2)
      get :index
      expect(assigns(:patents)).to match_array([patent, patent2])
    end
  end

  describe "Post #create" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
    end

    context "with valid attributes" do
      it "saves the new patent in the database" do
        expect{
          post :create, :patent=>attributes_for(:patent, :user_id=>@user.id)
        }.to change(Patent, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new patent in the database, when pass invalid title" do
        expect{
          post :create, :patent=>attributes_for(:patent, :title=>nil, :user_id=>@user.id)
        }.not_to change(Patent, :count)
      end

      it "doesn't save the new patent in the database, when don't pass user_id" do
        expect{
          post :create, :patent=>attributes_for(:patent, :user_id=>nil)
        }.to raise_error
      end
    end
  end

  describe "Put #update" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user
      @patent = create(:patent, :user=>@user)
    end

    context "with valid attributes" do
      it "changes the patent's attributes" do
        @user2 = create(:user_student_2, :group=>@group)
        put :update, :id=>@patent.id, :patent=>attributes_for(:patent, :title=>"Smart house", :user_id=>@user2.id)
        @patent.reload
        expect(@patent.title).to eq "Smart house"
        expect(@patent.user).to eq @user2
      end
    end

    context "with invalid attributes" do
      it "doesn't change the patent's attributes, when pass invalid status" do
        put :update, :id=>@patent.id, :patent=>attributes_for(:patent, :title=>"Smart house", :status=>"one", :user_id=>@user.id)
        @patent.reload
        expect(@patent.title).not_to eq "Smart house"
        expect(@patent.status).to eq Setting.patents.status_writing
      end

      it "doesn't change the patent's attributes, when don't pass user_id" do
        expect{
          put :update, :id=>@patent.id, :patent=>attributes_for(:patent, :user_id=>nil)
        }.to raise_error
      end
    end
  end

  describe "Delete #destory" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
      @patent = create(:patent, :user=>@user)
    end

    it "deletes the patent" do
      expect{
        delete :destroy, :id=>@patent.id
      }.to change(Patent, :count).by(-1)
    end
  end
end
