require 'spec_helper'

describe ThesesController do

  describe "Get #index" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user

      @group2 = create(:group_2)
      @user2 = create(:user_student_2, :group=>@group2)
    end

    it "populates an array of theses belong to user's group" do
      thesis = create(:thesis, :user=>@user)
      thesis2 = create(:thesis_2, :user=>@user)
      thesis3 = create(:thesis_3, :user=>@user2)
      get :index
      expect(assigns(:theses)).to match_array([thesis, thesis2])
    end
  end

  describe "Post #create" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
    end

    context "with valid attributes" do
      it "saves the new thesis in the database" do
        expect{
          post :create, :thesis=>attributes_for(:thesis)
        }.to change(Thesis, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new thesis in the database, when pass invalid title" do
        expect{
          post :create, :thesis=>attributes_for(:thesis, :title=>nil)
        }.not_to change(Thesis, :count)
      end
    end
  end

  describe "Put #update" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
      @thesis = create(:thesis, :user=>@user)
    end

    context "with valid attributes" do
      it "changes the thesis's attributes" do
        put :update, :id=>@thesis.id, :thesis=>attributes_for(:thesis, :title=>"Smart house")
        @thesis.reload
        expect(@thesis.title).to eq "Smart house"
      end
    end

    context "with invalid attributes" do
      it "doesn't change the thesis's attributes, when pass invalid status" do
        put :update, :id=>@thesis.id, :thesis=>attributes_for(:thesis, :title=>"Smart house", :status=>"one")
        @thesis.reload
        expect(@thesis.title).not_to eq "Smart house"
        expect(@thesis.status).to eq Setting.theses.status_proposal
      end
    end
  end

  describe "Delete #destory" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
      @thesis = create(:thesis, :user=>@user)
    end

    it "deletes the thesis" do
      expect{
        delete :destroy, :id=>@thesis.id
      }.to change(Thesis, :count).by(-1)
    end
  end
end
